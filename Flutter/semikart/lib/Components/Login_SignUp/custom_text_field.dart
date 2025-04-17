import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final EdgeInsetsGeometry? padding; // Optional padding parameter
  final double width; // New width parameter with default value
  final double? height; // Optional height parameter
  final Widget? suffixIcon; // Optional suffix icon parameter
  final Function(String)? onChanged; // Optional onChanged callback
  final FocusNode? focusNode; // Optional FocusNode parameter
  final VoidCallback? onTap; // Optional onTap callback
  final FormFieldValidator<String>? validator; // Optional external validator

  const CustomTextField({
    super.key,
    required this.controller, // Constructor
    required this.label,
    this.isPassword = false,
    this.padding, // Optional padding parameter
    this.width = 370.0, // Default width
    this.height, // Optional height parameter
    this.suffixIcon, // Optional suffix icon
    this.onChanged, // Optional onChanged callback
    this.focusNode, // Optional FocusNode
    this.onTap, // Optional onTap callback
    this.validator, // Add validator to constructor
  });

  // Standard email validation regex
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  @override
  Widget build(BuildContext context) {
    // Calculate the width dynamically based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    // Limit width to 90% of screen width if default width is larger
    final calculatedWidth = width == 370.0 // Check if it's the default width
        ? screenWidth * 0.9 // If default, use 90% of screen width
        : (width > screenWidth * 0.9 ? screenWidth * 0.9 : width); // Otherwise, use provided width capped at 90%

    // Define the email validator only if the label is 'Email' (case-insensitive)
    FormFieldValidator<String>? emailValidator;
    if (label.toLowerCase() == 'email') {
      emailValidator = (value) {
        if (value == null || value.isEmpty) {
          // Return null if empty is allowed, or an error message if required
          // return 'Please enter an email'; // Uncomment if email is required
          return null; // Currently allows empty email
        }
        if (!_emailRegExp.hasMatch(value)) {
          return 'Please enter a valid email'; // Validation message
        }
        return null; // Return null if valid
      };
    }

    // Use TextFormField for validation capabilities
    final formField = Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 0), // Default padding to 0 if null
      child: SizedBox(
        width: calculatedWidth, // Use the dynamically calculated width
        height: height, // Use the provided height (can be null)
        child: TextFormField( // Changed from TextField to TextFormField
          controller: controller,
          focusNode: focusNode, // Attach the FocusNode
          obscureText: isPassword, // Toggle password visibility if it's a password field
          onChanged: onChanged, // Call the onChanged callback if provided
          onTap: onTap, // Attach the onTap callback
          validator: validator ?? emailValidator, // Use provided validator OR the email validator
          autovalidateMode: AutovalidateMode.onUserInteraction, // Validate when user interacts
          cursorHeight: (height ?? 72) * 0.5, // Adjust cursor height based on potential height
          cursorWidth: 1.5, // Make the cursor slightly thinner
          cursorColor: Colors.black, // Set the cursor color to black
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: Color(0xFF757575), // Grey color for placeholder
              fontSize: 16,
              height: 1.2, // Adjust height for better vertical alignment
            ),
            floatingLabelStyle: const TextStyle(
              color: Color(0xFFA51414), // Red color when focused
              fontSize: 16,
              fontWeight: FontWeight.bold, // Make the label bold to match the border weight
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto, // Automatically transition the label
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0), // Center text vertically
            border: OutlineInputBorder( // Keep existing border style
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFA51414),
                width: 2.0, // Increased border width
              ),
            ),
            enabledBorder: OutlineInputBorder( // Keep existing border style
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFA51414),
                width: 2.0, // Increased border width
              ),
            ),
            focusedBorder: OutlineInputBorder( // Keep existing border style
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFA51414), // Red border when focused
                width: 2.0, // Increased border width
              ),
            ),
            // Define error border style - uses red color but same shape/width
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.red, // Standard error color
                width: 2.0,
              ),
            ),
            // Define focused error border style - uses red color but same shape/width
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            // Define error style for the message text itself
            errorStyle: const TextStyle(
              color: Colors.red, // Standard error text color
              fontSize: 12, // Slightly smaller font for error message
            ),
            suffixIcon: suffixIcon, // Add the optional suffix icon
          ),
          style: const TextStyle(
            fontSize: 16, // Adjust font size for input text
            height: 1.2, // Adjust height for better vertical alignment
          ),
          textAlignVertical: TextAlignVertical.center, // Vertically center the text
        ),
      ),
    );

    return formField;
  }
}
