import 'package:flutter/material.dart';
import 'Loginpassword.dart'; // Import the LoginPassword screen
import 'LoginOTP.dart'; // Import the LoginOTP screen

class HorizontalRadios extends StatefulWidget {
  final String initialOption; // Add a parameter to set the initial selected option

  HorizontalRadios({required this.initialOption}); // Constructor to accept the initial option

  @override
  _HorizontalRadiosState createState() => _HorizontalRadiosState();
}

class _HorizontalRadiosState extends State<HorizontalRadios> {
  late String _selectedOption; // Track the selected option

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialOption; // Initialize with the passed option
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamically calculate dimensions
    final radioSize = screenHeight * 0.03; // Adjusted size for radio buttons
    final textFontSize = screenHeight * 0.015; // Adjusted font size for labels

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space out the radios evenly
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // First Radio (Login with Password)
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: radioSize,
              height: radioSize,
              child: Radio<String>(
                value: "password", // Value for the first radio
                groupValue: _selectedOption, // Current selected option
                activeColor: Color(0xFFA51414), // Red color for selected radio
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedOption = value; // Update the selected radio option
                    });
                    // Navigate to LoginPassword screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPasswordScreen()),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 4), // Spacing between radio and text
            Text(
              "Password",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: textFontSize,
                fontWeight: FontWeight.normal,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),

        // Second Radio (Login with OTP)
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: radioSize,
              height: radioSize,
              child: Radio<String>(
                value: "otp", // Value for the second radio
                groupValue: _selectedOption, // Current selected option
                activeColor: Color(0xFFA51414), // Red color for selected radio
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedOption = value; // Update the selected radio option
                    });
                    // Navigate to LoginOTP screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginOTPScreen()),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 4), // Spacing between radio and text
            Text(
              "OTP",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: textFontSize,
                fontWeight: FontWeight.normal,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      ],
    );
  }
}