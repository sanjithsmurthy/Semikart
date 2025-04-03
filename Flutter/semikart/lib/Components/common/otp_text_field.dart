import 'dart:async';
import 'package:flutter/material.dart';

class OtpTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final EdgeInsetsGeometry? padding; // Optional padding parameter
  final double width; // Width of the text field

  const OtpTextField({
    super.key,
    required this.controller,
    required this.label,
    this.padding,
    this.width = 370.0, // Default width
  });

  @override
  _OtpTextFieldState createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  Timer? _timer;
  int _remainingTime = 120; // 2 minutes in seconds

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the widget is initialized
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    _remainingTime = 120; // Reset the timer to 2 minutes
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

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
          keyboardType: TextInputType.number, // Set keyboard type to number for OTP
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
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto, // Automatically transition the label
            contentPadding: const EdgeInsets.only(left: 29.0, top: 20, bottom: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFA51414),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFA51414),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFA51414),
                width: 1.0,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                _remainingTime > 0 ? _formatTime(_remainingTime) : "Resend OTP",
                style: const TextStyle(
                  color: Color(0xFF757575), // Grey color for the timer
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}