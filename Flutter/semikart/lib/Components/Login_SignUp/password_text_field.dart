import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final EdgeInsetsGeometry? padding; // Optional padding parameter
  final double width; // Width of the text field

  const PasswordTextField({
    super.key,
    required this.controller,
    required this.label,
    this.padding,
    this.width = 370.0, // Default width
  });

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isPasswordVisible = false; // State to toggle password visibility

  @override
  Widget build(BuildContext context) {
    // Calculate the width dynamically based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final calculatedWidth = widget.width > screenWidth * 0.9 ? screenWidth * 0.9 : widget.width; // Limit width to 90% of screen width

    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: calculatedWidth, // Use the dynamically calculated width
        height: 72,
        child: TextField(
          controller: widget.controller,
          obscureText: !_isPasswordVisible, // Toggle password visibility
          obscuringCharacter: '•', // Use a medium-sized dot character
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(
              color: Color(0xFF757575), // Grey color for placeholder
              fontSize: 16,
              height: 19 / 16, // To achieve height of 19
            ),
            floatingLabelStyle: const TextStyle(
              color: Color(0xFFA51414), // Red color when focused
              fontSize: 16,
              fontWeight: FontWeight.bold, // Make the floating label bold
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto, // Automatically transition the label
            contentPadding: const EdgeInsets.only(left: 29.0, top: 20, bottom: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFA51414),
                width: 2.0, // Increased border width
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFA51414),
                width: 2.0, // Increased border width
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFA51414),
                width: 2.0, // Increased border width
              ),
            ),
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
        ),
      ),
    );
  }
}