//finalized red text field with email label

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final EdgeInsetsGeometry? padding;

  const CustomTextField({super.key, 
    required this.controller, //constructor
    required this.label,
    this.isPassword = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final textField = Padding(
      padding: EdgeInsets.only(left: 22.0),
      child: SizedBox(
        width: 370,
        height: 72,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            // Default/unfocused label style (placeholder)
            labelStyle: TextStyle(
              color: Color(0xFF757575),
              fontSize: 16,
              height: 19/16,
              fontFamily: 'Product Sans',
            ),
            // Focused/floating label style
            floatingLabelStyle: TextStyle(
              color: Color(0xFFA51414),
              backgroundColor: Colors.white,
              fontSize: 16,
              fontFamily: 'Product Sans',
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
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
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 16,
            fontFamily: 'Product Sans',
          ),
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
