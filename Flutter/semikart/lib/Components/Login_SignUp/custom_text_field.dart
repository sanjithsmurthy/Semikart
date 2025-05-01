import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart'; // Keep this import

// Adjust path

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final EdgeInsetsGeometry? padding; // Optional padding parameter
  final double? width; // Allow width to be nullable or keep default
  final double? height; // Optional height parameter
  final Widget? suffixIcon; // Optional suffix icon parameter
  final Function(String)? onChanged; // Optional onChanged callback
  final FocusNode? focusNode; // Optional FocusNode parameter
  final VoidCallback? onTap; // Optional onTap callback
  final FormFieldValidator<String>? validator; // Optional external validator for VISUAL feedback (if needed)
  final void Function(bool isValid)? onValidationChanged; // New callback for validity status
  final bool readOnly; // Add readOnly property
  final TextInputType? keyboardType; // Added for keyboard type

  const CustomTextField({
    super.key,
    required this.controller, // Constructor
    required this.label,
    this.isPassword = false,
    this.padding, // Optional padding parameter
    this.width, // Allow nullable width
    this.height, // Optional height parameter
    this.suffixIcon, // Optional suffix icon
    this.onChanged, // Optional onChanged callback
    this.focusNode, // Optional FocusNode
    this.onTap, // Optional onTap callback
    this.validator, // Optional external validator
    this.onValidationChanged, // Add new callback to constructor
    this.readOnly = false, // Default to false
    this.keyboardType, // Added
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the width dynamically based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    // Always use 90% of screen width
    final calculatedWidth = screenWidth * 0.9;

    // Determine if email validation logic should be applied internally
    final bool isEmailField = label.toLowerCase() == 'email';

    // Define the border style - same for all states to prevent visual changes
    var borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color(0xFFA51414), // Keep the red border color consistent
        width: 1.0, // Consistent border width
      ),
    );

    return TextSelectionTheme(
      data: TextSelectionThemeData(
        selectionColor: const Color(0xFFA51414), // Highlight color for selected text
        selectionHandleColor: const Color(0xFFA51414), // Color for the drop icon
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 0), // Default padding to 0 if null
        child: SizedBox(
          width: calculatedWidth, // Use the consistent 90% screen width
          height: height, // Use the provided height (can be null)
          child: TextFormField(
            controller: controller,
            focusNode: focusNode, // Attach the FocusNode
            obscureText: isPassword, // Toggle password visibility if it's a password field
            readOnly: readOnly, // Use the readOnly property
            // --- Modified onChanged ---
            onChanged: (value) {
              // 1. Perform email validation using the package if applicable
              if (isEmailField && onValidationChanged != null) {
                // Use EmailValidator.validate()
                bool isValid = EmailValidator.validate(value);
                onValidationChanged!(isValid); // Report status to parent
              }
              // 2. Call the user-provided onChanged callback if it exists
              if (onChanged != null) {
                onChanged!(value);
              }
            },
            onTap: onTap, // Attach the onTap callback
            validator: validator, // Use external validator if provided
            // autovalidateMode can be adjusted based on external validator needs
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorHeight: (height ?? 60) * 0.5, // Adjust cursor height based on potential height
            cursorWidth: 1, // Make the cursor slightly thinner
            cursorColor: const Color(0xFFA51414), // Set the cursor color to black
            keyboardType: keyboardType, // Pass the keyboardType
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                color: Color(0xFF757575), // Grey color for placeholder
                fontSize: 16,
                height: 1.2, // Adjust height for better vertical alignment
              ),
              floatingLabelStyle: const TextStyle(
                color: Color(0xFFA51414), // Red color when focused (matches border)
                fontSize: 16,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto, // Automatically transition the label
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0), // Center text vertically
              // Use the same border style for ALL states
              border: borderStyle,
              enabledBorder: borderStyle,
              focusedBorder: borderStyle,
              errorBorder: borderStyle, // Use the same style even for error state
              focusedErrorBorder: borderStyle, // Use the same style even for focused error state
              errorStyle: const TextStyle(height: 0, fontSize: 0), // Hide error text completely
              suffixIcon: suffixIcon, // Add the optional suffix icon
            ),
            style: const TextStyle(
              fontSize: 16, // Adjust font size for input text
              height: 1.2, // Adjust height for better vertical alignment
            ),
            textAlignVertical: TextAlignVertical.center, // Vertically center the text
          ),
        ),
      ),
    );
  }
}

// --- Example Parent Screen Usage ---
class YourParentScreen extends StatefulWidget {
  @override
  _YourParentScreenState createState() => _YourParentScreenState();
}

class _YourParentScreenState extends State<YourParentScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  // ... other controllers ...

  bool isEmailValid = false; // State variable to track email validity
  // ... other state variables for button enabling ...

  @override
  Widget build(BuildContext context) {
    // Determine overall button state based on email validity and other conditions
    bool isButtonEnabled = isEmailValid /* && other conditions... */;

    return Scaffold(
      // ... AppBar, etc. ...
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // ... other widgets ...

                  CustomTextField(
                    controller: emailController,
                    label: "Email",
                    // Pass the callback function
                    onValidationChanged: (isValid) {
                      // Update the state in the parent when validity changes
                      // Use setState only if the value actually changed to avoid unnecessary rebuilds
                      if (isEmailValid != isValid) {
                         setState(() {
                           isEmailValid = isValid;
                         });
                      }
                    },
                  ),

                  // ... other fields ...

                  ElevatedButton(
                    // Enable/disable based on the state variable
                    onPressed: isButtonEnabled
                        ? () {
                            // Proceed with login/signup
                            print("Email is valid: $isEmailValid - Proceeding...");
                          }
                        : null, // Disable button if not enabled
                    child: const Text('Login / Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

   @override
  void dispose() {
    emailController.dispose();
    // ... dispose other controllers ...
    super.dispose();
  }
}
