import 'package:flutter/material.dart';
import 'password_text_field.dart'; // Import for the password field
import 'custom_text_field.dart'; // Import for the custom field

class ConfirmPasswordScreen extends StatefulWidget {
  final void Function(bool match)? onPasswordsMatch; // Optional callback for passwords match
  final double? width; // Optional width parameter
  final double height; // Required height parameter

  ConfirmPasswordScreen({
    this.onPasswordsMatch,
    this.width, // Optional width parameter
    required this.height, // Required height parameter
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
    final double effectiveWidth = widget.width ?? screenWidth * 0.9; // Default to 90% of screen width if width is not provided

    return Center(
      child: SizedBox(
        width: effectiveWidth, // Use the effective width
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: widget.height * 0.1), // Add top spacing dynamically

              // Password Field
              PasswordTextField(
                controller: passwordController,
                label: "Password", // Label for the password field
                width: effectiveWidth, // Use the effective width
                onChanged: (value) {
                  _validatePassword(value); // Validate password on change
                  _notifyPasswordMatch(); // Notify parent widget about password match
                },
              ),

              SizedBox(height: widget.height * 0.02), // Add spacing dynamically

              // Password Requirements Heading and List
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Password Requirements Heading
                  Text(
                    "YOUR PASSWORD MUST CONTAIN",
                    style: TextStyle(
                      fontSize: 12, // Font size 12
                      fontWeight: FontWeight.bold, // Bold text
                      color: _areAllRequirementsSatisfied() ? Colors.black : Color(0xFF989DA3), // Black if all requirements are satisfied, grey otherwise
                      fontFamily: 'Product Sans', // Product Sans font
                    ),
                  ),

                  SizedBox(height: widget.height * 0.01), // Add spacing below the heading

                  // Password Requirements List
                  _buildRequirementItem("Between 8 and 20 characters", hasMinLength),
                  SizedBox(height: widget.height * 0.015), // Dynamic spacing
                  _buildRequirementItem("1 upper case letter", hasUpperCase),
                  SizedBox(height: widget.height * 0.015), // Dynamic spacing
                  _buildRequirementItem("1 or more numbers", hasNumber),
                  SizedBox(height: widget.height * 0.015), // Dynamic spacing
                  _buildRequirementItem("1 or more special characters", hasSpecialChar),
                ],
              ),

              SizedBox(height: widget.height * 0.03), // Add spacing dynamically

              // Confirm Password Field
              CustomTextField(
                controller: confirmPasswordController,
                label: "Confirm Password", // Label for the confirm password field
                width: effectiveWidth, // Use the effective width
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
                  padding: EdgeInsets.only(top: widget.height * 0.01), // Add spacing above the alert
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
                          fontFamily: 'Product Sans', // Product Sans font
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
          Icons.circle, // Grey or black dot
          size: 12, // Big size for the dot
          color: isSatisfied ? Colors.black : Color(0xFF989DA3), // Black for satisfied, grey otherwise
        ),
        SizedBox(width: 8), // Add spacing between the dot and text
        Text(
          text,
          style: TextStyle(
            fontSize: 11, // Fixed font size
            fontWeight: FontWeight.w600, // Semi-bold font weight
            color: isSatisfied ? Colors.black : Color(0xFF989DA3), // Black for satisfied, grey otherwise
            fontFamily: 'Product Sans', // Product Sans font
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