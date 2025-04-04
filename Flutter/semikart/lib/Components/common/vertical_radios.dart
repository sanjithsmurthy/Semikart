import 'package:flutter/material.dart';
import '../Login_SignUp/Loginpassword.dart'; // Import the LoginPasswordScreen widget
import '../Login_SignUp/LoginOTP.dart';

class VerticalRadios extends StatefulWidget {
  @override
  _VerticalRadiosState createState() => _VerticalRadiosState();
}

class _VerticalRadiosState extends State<VerticalRadios> {
  String _selectedOption = "password"; // Default selected option

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamically calculate dimensions
    final containerWidth = screenWidth * 0.23; // 23% of screen width
    final containerHeight = screenHeight * 0.086; // 8.6% of screen height
    final radioSize = (containerHeight * 0.42) + 3; // Increase radio size by 3px
    final textFontSize = containerHeight * 0.15; // 15% of container height

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(containerWidth * 0.08), // 8% of container width
        border: Border.all(color: Colors.white, width: 1.0), // White border
      ),
      child: Stack(
        children: [
          // First Radio (Login with Password)
          Positioned(
            top: 0,
            left: 5, // Push the radio 5px to the right
            child: Transform.translate(
              offset: Offset(-10, 0), // Shift text 10px to the left
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: radioSize,
                    height: radioSize,
                    child: Radio<String>(
                      value: "password",
                      groupValue: _selectedOption,
                      activeColor: Color(0xFFA51414), // Red color for selected radio
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPasswordScreen(), // Navigate to LoginPassword
        ),
      );

                        });
                      },
                    ),
                  ),
                  SizedBox(width: 5), // Spacing between radio and text set to 5px
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login with",
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: textFontSize,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Text(
                        "Password",
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
              ),
            ),
          ),

          // Second Radio (Login with OTP)
          Positioned(
            bottom: 0,
            left: 5, // Push the radio 5px to the right
            child: Transform.translate(
              offset: Offset(-10, 0), // Shift text 10px to the left
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: radioSize,
                    height: radioSize,
                    child: Radio<String>(
                      value: "otp",
                      groupValue: _selectedOption,
                      activeColor: Color(0xFFA51414), // Red color for selected radio
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          
                          Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginOTPScreen(), // Navigate to LoginOTP
        ),
      );
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 5), // Spacing between radio and text set to 5px
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login with",
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: textFontSize,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Text(
                        "OTP",
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}