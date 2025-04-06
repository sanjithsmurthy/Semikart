import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final EdgeInsetsGeometry? padding; // Optional padding parameter
  final double width; // New width parameter with default value

  const CustomTextField({
    super.key,
    required this.controller, // Constructor
    required this.label,
    this.isPassword = false,
    this.padding, // Optional padding parameter
    this.width = 370.0, // Default width
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the width dynamically based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final calculatedWidth = width > screenWidth * 0.9 ? screenWidth * 0.9 : width; // Limit width to 90% of screen width

    final textField = Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: calculatedWidth, // Use the dynamically calculated width
        height: 72,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Color(0xFF757575), // Grey color for placeholder
              fontSize: 16,
              height: 19 / 16, // To achieve height of 19
            ),
            floatingLabelStyle: TextStyle(
              color: Color(0xFFA51414), // Red color when focused
              fontSize: 16,
              fontWeight: FontWeight.bold, // Make the label bold to match the border weight
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto, // Automatically transition the label
            contentPadding: EdgeInsets.only(left: 29.0, top: 20, bottom: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Color(0xFFA51414),
                width: 2.0, // Increased border width
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Color(0xFFA51414),
                width: 2.0, // Increased border width
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Color(0xFFA51414), // Red border when focused
                width: 2.0, // Increased border width
              ),
            ),
          ),
          obscureText: isPassword,
        ),
      ),
    );

    return textField;
  }
}
