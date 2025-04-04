import 'package:flutter/material.dart';
import 'dart:async'; // Import for the timer

class OTPTextField extends StatefulWidget {
  final TextEditingController controller; // Controller to capture the OTP
  final String label; // Label for the OTP field
  final Function(String)? onCompleted; // Callback when OTP is completed

  OTPTextField({
    required this.controller,
    this.label = "Enter OTP",
    this.onCompleted, required Null Function(dynamic otp) onChanged,
  });

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  bool isSending = false; // To track the "Send OTP" button state
  bool canResend = true; // To track if "Send OTP" is clickable
  int countdown = 0; // Countdown timer duration in seconds
  Timer? timer; // Timer object

  void startCountdown() {
    setState(() {
      countdown = 120; // Set the countdown duration to 2 minutes (120 seconds)
      canResend = false; // Disable "Send OTP" button
    });

    timer?.cancel(); // Cancel any existing timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel(); // Stop the timer when it reaches 0
        setState(() {
          canResend = true; // Enable "Send OTP" button
        });
      }
    });
  }

  void handleSendOTP() {
    if (!canResend) return; // Prevent clicking if the timer is active

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
            canResend ? 'Send OTP' : 'Resend OTP in ${countdown ~/ 60}:${(countdown % 60).toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Product Sans',
              color: canResend ? Colors.black : Colors.grey, // Grey when disabled
            ),
          ),
        ),
        SizedBox(height: 16), // Space between "Send OTP" and OTP field

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
            if (widget.onCompleted != null && value.isNotEmpty) {
              widget.onCompleted!(value); // Trigger the callback when OTP is entered
            }
          },
        ),
      ],
    );
  }
}