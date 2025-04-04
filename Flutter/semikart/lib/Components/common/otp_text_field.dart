import 'package:flutter/material.dart';
import 'dart:async'; // Import for the timer

class OTPTextField extends StatefulWidget {
  final TextEditingController controller; // Controller to capture the OTP
  final String label; // Label for the OTP field
  final Function(String)? onCompleted; // Callback when OTP is completed

  OTPTextField({
    required this.controller,
    this.label = "Enter OTP",
    this.onCompleted,
  });

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  bool isSending = false; // To track the "Send OTP" button state
  int countdown = 0; // Countdown timer duration in seconds
  Timer? timer; // Timer object

  void startCountdown() {
    setState(() {
      countdown = 30; // Set the countdown duration to 30 seconds
    });

    timer?.cancel(); // Cancel any existing timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  void handleSendOTP() {
    setState(() {
      isSending = true; // Change the text color to A51414
    });

    // Wait for 1 second before resetting the color
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isSending = false; // Reset the text color to black
      });
    });

    // Start the countdown timer
    startCountdown();
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "Send OTP" text
        GestureDetector(
          onTap: handleSendOTP,
          child: Text(
            'Send OTP',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Product Sans',
              color: isSending ? Color(0xFFA51414) : Colors.black,
            ),
          ),
        ),
        SizedBox(height: 8), // Space between "Send OTP" and countdown
        if (countdown > 0)
          Text(
            'Resend OTP in $countdown seconds',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Product Sans',
              color: Colors.grey,
            ),
          ),
        SizedBox(height: 16), // Space between countdown and OTP field

        // OTP field styled like CustomTextField
        TextField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(
              fontFamily: 'Product Sans',
              fontSize: 14,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xFFA51414), // Focused border color
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
          ),
          style: TextStyle(
            fontFamily: 'Product Sans',
            fontSize: 16,
            color: Colors.black,
          ),
          onChanged: (value) {
            if (widget.onCompleted != null && value.length > 0) {
              widget.onCompleted!(value); // Trigger the callback when OTP is entered
            }
          },
        ),
      ],
    );
  }
}