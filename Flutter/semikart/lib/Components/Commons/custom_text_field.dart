//finalized red text field with email label

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final EdgeInsetsGeometry? padding;  // New padding parameter

  CustomTextField({
    required this.controller, //constructor
    required this.label,
    this.isPassword = false,
    this.padding,  // Optional padding parameter
  });
  
  get textField => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 22.0),
      child: SizedBox(
        width: 370,
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
                  height: 19/16, // To achieve height of 19
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

    return padding != null ? Padding(
      padding: padding!,
      child: textField,
    ) : textField;
  }
}
