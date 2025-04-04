import 'package:flutter/material.dart';

class OTPTextField extends StatelessWidget {
  final int length; // Number of OTP fields
  final TextEditingController controller; // Controller to capture the OTP
  final double fieldWidth; // Width of each OTP field
  final double fieldHeight; // Height of each OTP field
  final double spacing; // Spacing between OTP fields
  final Function(String)? onCompleted; // Callback when OTP is completed

  OTPTextField({
    required this.length,
    required this.controller,
    this.fieldWidth = 50.0,
    this.fieldHeight = 50.0,
    this.spacing = 8.0,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Container(
          width: fieldWidth,
          height: fieldHeight,
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: TextField(
            controller: TextEditingController(),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '', // Hide the character counter
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < length - 1) {
                FocusScope.of(context).nextFocus(); // Move to the next field
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus(); // Move to the previous field
              }

              // Collect the OTP when all fields are filled
              String otp = '';
              for (int i = 0; i < length; i++) {
                otp += (controller.text.length > i ? controller.text[i] : '');
              }
              if (otp.length == length && onCompleted != null) {
                onCompleted!(otp);
              }
            },
          ),
        );
      }),
    );
  }
}