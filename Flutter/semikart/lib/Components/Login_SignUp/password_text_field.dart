import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final EdgeInsetsGeometry? padding; // Optional padding parameter
  final double? width; // Allow width to be nullable
  final double? height; // Optional height parameter
  final Function(String)? onChanged; // Optional onChanged callback

  const PasswordTextField({
    super.key,
    required this.controller,
    required this.label,
    this.padding,
    this.width, // Removed default width
    this.height, // Optional height parameter
    this.onChanged, // Optional onChanged callback
  });

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isPasswordVisible = false; // State to toggle password visibility

  @override
  Widget build(BuildContext context) {
    // Calculate the width dynamically based on screen size - SAME AS CustomTextField
    final screenWidth = MediaQuery.of(context).size.width;
    final calculatedWidth = screenWidth * 0.9; // Always use 90% of screen width

    // Define the border style - same for all states to prevent visual changes
    var borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Color(0xFFA51414), // Keep the red border color consistent
        width: 2.0, // Consistent border width
      ),
    );

    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 0), // Default padding to 0 if null
      child: SizedBox(
        width: calculatedWidth, // Use the consistent 90% screen width
        height: widget.height, // Use the provided height (can be null)
        child: TextField( // Using TextField as validation is handled differently for passwords usually
          controller: widget.controller,
          obscureText: !_isPasswordVisible, // Toggle password visibility
          obscuringCharacter: '•', // Use a medium-sized dot character
          onChanged: widget.onChanged, // Call the onChanged callback if provided
          cursorHeight: 20.0, // Use fixed smaller cursor height
          cursorWidth: 1.5, // Make the cursor slightly thinner
          cursorColor: Colors.black, // Set the cursor color to black
          textAlignVertical: TextAlignVertical.center, // Vertically center the text
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(
              color: Color(0xFF757575), // Grey color for placeholder
              fontSize: 16,
              height: 1.2, // Adjust height for better vertical alignment
            ),
            floatingLabelStyle: const TextStyle(
              color: Color(0xFFA51414), // Red color when focused
              fontSize: 16,
              // fontWeight: FontWeight.bold, // Removed bold to reduce visual change
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto, // Automatically transition the label
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0), // Adjusted padding to match CustomTextField
            // Use the same border style for ALL states
            border: borderStyle,
            enabledBorder: borderStyle,
            focusedBorder: borderStyle,
            errorBorder: borderStyle, // Keep consistent even if not using validator here
            focusedErrorBorder: borderStyle, // Keep consistent
            errorStyle: const TextStyle(height: 0, fontSize: 0), // Hide error text space
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off_sharp : Icons.visibility_sharp, // Toggle icon
                color: const Color(0xFFA51414), // Red color for the icon
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                });
              },
            ),
          ),
          style: const TextStyle(
            fontSize: 16, // Adjust font size for input text
            height: 1.2, // Adjust height for better vertical alignment
          ),
        ),
      ),
    );
  }
}