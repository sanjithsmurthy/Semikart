import 'package:flutter/material.dart';
import 'login_password_new.dart'; // Import the LoginPassword screen
import 'login_otp.dart'; // Import the LoginOTP screen

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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(), // Takes up space before the first radio group

        // First Radio (Login with Password)
        Row(
          mainAxisSize: MainAxisSize.min, // Ensure this Row takes minimum space
          children: [
            SizedBox(
              width: radioSize,
              height: radioSize,
              child: Radio<String>(
                value: "password", // Value for the first radio
                groupValue: _selectedOption, // Current selected option
                activeColor: Color(0xFFA51414), // Red color for selected radio
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area
                visualDensity: VisualDensity.compact, // Make radio more compact
                onChanged: (value) {
                  if (value != null && value != _selectedOption) { // Prevent re-navigation if already selected
                    setState(() {
                      _selectedOption = value; // Update the selected radio option
                    });
                    // Navigate to LoginPassword screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPasswordNewScreen()),
                    );
                  }
                },
              ),
            ),
            // const SizedBox(width: 4), // Spacing between radio and text (optional)
            Text(
              "Password",
              style: TextStyle(
                fontSize: textFontSize,
                fontWeight: FontWeight.normal,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),

        // Explicit space between the two radio groups - Reduced width
        SizedBox(width: screenWidth / 4), // Space is 1/4 of screen width (Adjust as needed)

        // Second Radio (Login with OTP)
        Row(
          mainAxisSize: MainAxisSize.min, // Ensure this Row takes minimum space
          children: [
            SizedBox(
              width: radioSize,
              height: radioSize,
              child: Radio<String>(
                value: "otp", // Value for the second radio
                groupValue: _selectedOption, // Current selected option
                activeColor: Color(0xFFA51414), // Red color for selected radio
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area
                visualDensity: VisualDensity.compact, // Make radio more compact
                onChanged: (value) {
                  if (value != null && value != _selectedOption) { // Prevent re-navigation if already selected
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
            // const SizedBox(width: 4), // Spacing between radio and text (optional)
            Text(
              "OTP",
              style: TextStyle(
                fontSize: textFontSize,
                fontWeight: FontWeight.normal,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),

        const Spacer(), // Takes up space after the second radio group
      ],
    );
  }
}