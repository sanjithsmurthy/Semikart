//finalized red text field with email label

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
    final textField = Padding(
      padding: EdgeInsets.only(left: 22.0),
      child: SizedBox(
        width: width, // Use the width parameter
        height: 72,
        child: Stack(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  color: Color(0xFFA51414),
                  backgroundColor: Colors.white,
                  fontSize: 16,
                  height: 19 / 16, // To achieve height of 19
                ),
                floatingLabelStyle: TextStyle(
                  color: Color(0xFFA51414),
                  backgroundColor: Colors.white,
                  fontSize: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: EdgeInsets.only(left: 29.0, top: 20, bottom: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xFFA51414),
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xFFA51414),
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xFFA51414),
                    width: 1.0,
                  ),
                ),
              ),
              obscureText: isPassword,
            ),
          ],
        ),
      ),
    );

    return padding != null
        ? Padding(
            padding: padding!,
            child: textField,
          )
        : textField;
  }
}
