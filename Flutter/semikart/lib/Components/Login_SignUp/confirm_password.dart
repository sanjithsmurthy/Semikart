import 'package:flutter/material.dart';
import 'password_text_field.dart'; // Import for the password field
import 'custom_text_field.dart'; // Import for the custom field

class ConfirmPasswordScreen extends StatefulWidget {
  final void Function(bool match)? onPasswordsMatch; // Optional callback for passwords match
  final double? width; // Optional width parameter
  final double? height; // Optional height parameter

  ConfirmPasswordScreen({
    super.key, // Added key
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
  void dispose() {
    // Dispose controllers when the widget is removed from the tree
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    // Use provided width or default to 90% of screen width (matching child fields)
    final double effectiveWidth = widget.width ?? screenWidth * 0.9;
    // Use provided height or let the Column size itself (null height)
    final double? effectiveHeight = widget.height;

    // Define dynamic sizes based on screen dimensions (can be adjusted)
    final double verticalSpacingSmall = screenHeight * 0.01;
    final double verticalSpacingMedium = screenHeight * 0.02;
    final double verticalSpacingLarge = screenHeight * 0.03;
    final double textFieldHeight = screenHeight * 0.06; // Example height
    final double headingFontSize = screenWidth * 0.04;
    final double requirementFontSize = screenWidth * 0.035;
    final double bulletIconSize = screenWidth * 0.03;
    final double checkIconSize = screenWidth * 0.05;
    final double alertIconSize = screenWidth * 0.04;
    final double alertFontSize = screenWidth * 0.03;

    // The outer SizedBox controls the overall width of this component
    return SizedBox(
      width: effectiveWidth, // Use the calculated effective width
      height: effectiveHeight, // Apply the effective height (can be null)
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start (left)
        mainAxisSize: MainAxisSize.min, // Make column take minimum vertical space if height is null
        children: [
          // Password Field - REMOVED width parameter
          PasswordTextField(
            controller: passwordController,
            label: "Password", // Label for the password field
            height: textFieldHeight, // Optional: Set height if needed
            onChanged: (value) {
              _validatePassword(value); // Validate password on change
              _notifyPasswordMatch(); // Notify parent widget about password match
            },
          ),

          SizedBox(height: verticalSpacingLarge), // Dynamic spacing

          // Password Requirements Heading and List
          // No extra padding needed if parent Column has padding
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Password Requirements Heading
              Text(
                "YOUR PASSWORD MUST CONTAIN",
                style: TextStyle(
                  fontSize: headingFontSize, // Dynamic font size
                  fontWeight: FontWeight.bold, // Bold text
                  color: Color(0xFF989DA3), // Grey text color
                   // Product Sans font (Ensure font is added to pubspec.yaml)
                ),
              ),

              SizedBox(height: verticalSpacingSmall), // Dynamic spacing

              // Password Requirements List
              _buildRequirementItem("Between 8 and 20 characters", hasMinLength, requirementFontSize, bulletIconSize, verticalSpacingSmall),
              SizedBox(height: verticalSpacingSmall), // Dynamic spacing
              _buildRequirementItem("1 upper case letter", hasUpperCase, requirementFontSize, bulletIconSize, verticalSpacingSmall),
              SizedBox(height: verticalSpacingSmall), // Dynamic spacing
              _buildRequirementItem("1 or more numbers", hasNumber, requirementFontSize, bulletIconSize, verticalSpacingSmall),
              SizedBox(height: verticalSpacingSmall), // Dynamic spacing
              _buildRequirementItem("1 or more special characters", hasSpecialChar, requirementFontSize, bulletIconSize, verticalSpacingSmall),
            ],
          ),

          SizedBox(height: verticalSpacingLarge), // Dynamic spacing

          // Confirm Password Field - REMOVED width parameter
          CustomTextField(
            controller: confirmPasswordController,
            height: textFieldHeight, // Optional: Set height if needed
            label: "Confirm Password", // Label for the confirm password field
            suffixIcon: Icon(
              _isPasswordMatching() && _areAllRequirementsSatisfied()
                  ? Icons.check // Green tick icon
                  : Icons.close, // Red cross icon
              size: checkIconSize, // Dynamic icon size
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
              padding: EdgeInsets.only(top: verticalSpacingSmall), // Dynamic spacing
              child: Row(
                children: [
                  Icon(
                    Icons.error, // Alert icon
                    color: Color(0xFFA51414), // Red color for the alert icon
                    size: alertIconSize, // Dynamic icon size
                  ),
                  SizedBox(width: screenWidth * 0.02), // Dynamic spacing between icon and text
                  Text(
                    "Passwords do not match",
                    style: TextStyle(
                      fontSize: alertFontSize, // Dynamic font size
                      fontWeight: FontWeight.w600, // Semi-bold font weight
                      color: Color(0xFFA51414), // Red color for the alert text
                       // Product Sans font (Ensure font is added to pubspec.yaml)
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Helper method to build each password requirement item with dynamic sizes
  Widget _buildRequirementItem(String text, bool isSatisfied, double fontSize, double iconSize, double spacing) {
    return Row(
      children: [
        Icon(
          Icons.circle, // Use a circle icon for the bullet
          size: iconSize, // Use dynamic icon size
          color: isSatisfied ? Color.fromARGB(255, 25, 107, 27) : Color(0xFF989DA3), // Dark green for satisfied, grey otherwise
        ),
        SizedBox(width: spacing * 2), // Dynamic spacing between bullet and text
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize, // Use dynamic font size
            fontWeight: FontWeight.w600, // Semi-bold font weight
            color: Color(0xFF989DA3), // Keep text color grey
             // Product Sans font (Ensure font is added to pubspec.yaml)
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
    // Ensure both fields are considered, even if empty initially
    return passwordController.text == confirmPasswordController.text;
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