import 'package:flutter/material.dart';
import 'password_text_field.dart'; // Import for the password field
import 'custom_text_field.dart'; // Import for the custom field
import 'confirm_password.dart'; // Import your ConfirmPasswordScreen

class ConfirmPasswordScreen extends StatefulWidget {
  final void Function(bool match)? onPasswordsMatch; // Optional callback for passwords match
  final double? width; // Optional width parameter
  final double? height; // Optional height parameter

  ConfirmPasswordScreen({
    this.onPasswordsMatch,
    this.width, // Optional width parameter
    this.height, // Optional height parameter
  });

  @override
  _ConfirmPasswordScreenState createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  final TextEditingController passwordController = TextEditingController(); // Controller for the password field
  final TextEditingController confirmPasswordController = TextEditingController(); // Controller for the confirm password field

  // Password validation flags
  bool hasMinLength = false;
  bool hasUpperCase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double effectiveWidth = widget.width ?? screenWidth * 0.9; // Default to 90% of screen width if width is not provided
    final double effectiveHeight = widget.height ?? screenHeight * 0.1; // Default to 10% of screen height if height is not provided

    return Center(
      child: SizedBox(
        width: effectiveWidth, // Use the effective width
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: effectiveHeight * 0.1), // Add top spacing dynamically

              // Password Field
              PasswordTextField(
                controller: passwordController,
                label: "Password", // Label for the password field
                width: screenWidth, // Specify width
                height: screenHeight * 0.06, // Use the effective height
                onChanged: (value) {
                  _validatePassword(value); // Validate password on change
                  _notifyPasswordMatch(); // Notify parent widget about password match
                },
              ),

              // Adjust spacing between the first text field and the heading
              SizedBox(height: effectiveHeight * 0.2), // Set spacing to 0.15 of effectiveHeight

              // Password Requirements Heading and List
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05), // Add left padding to push text to the right
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Password Requirements Heading
                    Text(
                      "YOUR PASSWORD MUST CONTAIN",
                      style: TextStyle(
                        fontSize: 16, // Increased font size
                        fontWeight: FontWeight.bold, // Bold text
                        color: Color(0xFF989DA3), // Grey text color
                         // Product Sans font
                      ),
                    ),

                    SizedBox(height: effectiveHeight * 0.03), // Add spacing below the heading

                    // Password Requirements List
                    _buildRequirementItem("Between 8 and 20 characters", hasMinLength),
                    SizedBox(height: effectiveHeight * 0.03), // Increased spacing between requirements
                    _buildRequirementItem("1 upper case letter", hasUpperCase),
                    SizedBox(height: effectiveHeight * 0.03), // Increased spacing between requirements
                    _buildRequirementItem("1 or more numbers", hasNumber),
                    SizedBox(height: effectiveHeight * 0.03), // Increased spacing between requirements
                    _buildRequirementItem("1 or more special characters", hasSpecialChar),
                  ],
                ),
              ),

              // Adjust spacing between the last requirement and the second text field
              SizedBox(height: effectiveHeight * 0.2), // Set spacing to 0.15 of effectiveHeight

              // Confirm Password Field
              CustomTextField(
                controller: confirmPasswordController,
                width: screenWidth, // Specify width
                height: screenHeight * 0.06, // Use the effective height
                label: "Confirm Password", // Label for the confirm password field
                suffixIcon: Icon(
                  _isPasswordMatching() && _areAllRequirementsSatisfied()
                      ? Icons.check // Green tick icon
                      : Icons.close, // Red cross icon
                  color: _isPasswordMatching() && _areAllRequirementsSatisfied()
                      ? Colors.green // Green color if all requirements are satisfied and passwords match
                      : Color(0xFFA51414), // Red color otherwise
                ),
                onChanged: (value) {
                  setState(() {}); // Update UI when confirm password changes
                  _notifyPasswordMatch(); // Notify parent widget about password match
                },
              ),

              // Alert Text for Password Mismatch
              if (!_isPasswordMatching() && confirmPasswordController.text.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: effectiveHeight * 0.01), // Add spacing above the alert
                  child: Row(
                    children: [
                      Icon(
                        Icons.error, // Alert icon
                        color: Color(0xFFA51414), // Red color for the alert icon
                        size: 16, // Icon size
                      ),
                      SizedBox(width: 8), // Spacing between the icon and text
                      Text(
                        "Passwords do not match",
                        style: TextStyle(
                          fontSize: 11, // Font size
                          fontWeight: FontWeight.w600, // Semi-bold font weight
                          color: Color(0xFFA51414), // Red color for the alert text
                           // Product Sans font
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build each password requirement item
  Widget _buildRequirementItem(String text, bool isSatisfied) {
    return Row(
      children: [
        Icon(
          Icons.circle, // Use a circle icon for the bullet
          size: 12, // Fixed size for the bullet
          color: isSatisfied ? Color.fromARGB(255, 25, 107, 27) : Color(0xFF989DA3), // Dark green for satisfied, grey otherwise
          // Dark green for satisfied, grey otherwise
        ),
        SizedBox(width: 8), // Add spacing between the bullet and text
        Text(
          text,
          style: TextStyle(
            fontSize: 11, // Fixed font size
            fontWeight: FontWeight.w600, // Semi-bold font weight
            color: Color(0xFF989DA3), // Keep text color grey
             // Product Sans font
          ),
        ),
      ],
    );
  }

  // Notify parent widget about password match
  void _notifyPasswordMatch() {
    if (widget.onPasswordsMatch != null) {
      widget.onPasswordsMatch!(_isPasswordMatching() && _areAllRequirementsSatisfied());
    }
  }

  // Validate password and update flags
  void _validatePassword(String password) {
    setState(() {
      hasMinLength = password.length >= 8 && password.length <= 20;
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  // Check if confirm password matches the password
  bool _isPasswordMatching() {
    return passwordController.text == confirmPasswordController.text &&
        confirmPasswordController.text.isNotEmpty;
  }

  // Check if all password requirements are satisfied
  bool _areAllRequirementsSatisfied() {
    return hasMinLength && hasUpperCase && hasNumber && hasSpecialChar;
  }
}

// Example Parent Screen (e.g., SignUpScreen.dart)
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordsMatch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      // resizeToAvoidBottomInset: true, // Default is true
      body: SafeArea(
        // Wrap the main content column/stack in SingleChildScrollView
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Add padding if needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ... other sign-up fields (like Email, Name, etc.) ...

                Text("Create Your Password"),
                SizedBox(height: 20),

                // Use your ConfirmPasswordScreen widget here
                ConfirmPasswordScreen(
                  onPasswordsMatch: (match) {
                    // Update state based on whether passwords match
                    setState(() {
                      _passwordsMatch = match;
                    });
                    print("Passwords match: $match");
                  },
                  // Pass width/height if needed, otherwise it uses defaults
                  // width: MediaQuery.of(context).size.width * 0.9,
                ),

                SizedBox(height: 30),

                // Example Sign Up Button (Enable based on password match)
                ElevatedButton(
                  onPressed: _passwordsMatch
                      ? () {
                          // Handle sign up logic
                          print("Sign Up button pressed");
                        }
                      : null, // Disable button if passwords don't match/requirements not met
                  child: Text("Sign Up"),
                ),

                // Add extra space at the bottom if needed to ensure
                // the button doesn't get stuck right above the keyboard
                SizedBox(height: 50),

              ],
            ),
          ),
        ),
      ),
    );
  }
}