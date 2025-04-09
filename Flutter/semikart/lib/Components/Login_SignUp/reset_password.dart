import 'package:flutter/material.dart';
import 'Loginpassword.dart'; // Import the LoginPasswordScreen
import 'forgot_password.dart'; // Import the ForgotPasswordScreen

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Back Button
          Positioned(
            left: screenWidth * 0.055, // 22px from the left
            top: screenHeight * 0.06, // 40px from the top
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFFA51414)), // Left-facing V icon
              iconSize: screenWidth * 0.07, // Dynamically scale the icon size
              onPressed: () {
                // Navigate back to ForgotPasswordScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                );
              },
            ),
          ),

          // Cross Icon
          Positioned(
            right: screenWidth * 0.055, // 22px from the right
            top: screenHeight * 0.06, // 40px from the top
            child: IconButton(
              icon: Icon(Icons.close, color: Color(0xFFA51414)), // Cross icon
              iconSize: screenWidth * 0.07, // Dynamically scale the icon size
              onPressed: () {
                // Navigate back to LoginPasswordScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPasswordScreen()),
                );
              },
            ),
          ),

          // ResetMan Image
          Positioned(
            top: screenHeight * 0.023, // Adjust top padding dynamically
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'public/assets/images/resetman.png', // Replace with the actual path to resetman.png
                width: screenWidth * 0.4, // Dynamically scale width
                height: screenHeight * 0.4, // Dynamically scale height
                fit: BoxFit.contain, // Ensure the image fits within the bounds
              ),
            ),
          ),

          // "Set Your Password" Text
          Positioned(
            top: screenHeight * 0.3, // Just below the image
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Set Your Password",
                style: TextStyle(
                  fontSize: screenWidth * 0.05, // Dynamically scale font size (20px for a 400px width screen)
                  fontWeight: FontWeight.bold, // Bold font weight
                  color: Colors.black, // Black color
                  fontFamily: 'Product Sans', // Product Sans font
                ),
              ),
            ),
          ),

          // Instruction Text
          Positioned(
            top: screenHeight * 0.35, // Just below the "Set Your Password" text
            left: screenWidth * 0.1, // Add padding from the left
            right: screenWidth * 0.1, // Add padding from the right
            child: Center(
              child: Text(
                "In order to keep your account safe you need\n"
                "to create a strong password.",
                textAlign: TextAlign.center, // Center align the text
                style: TextStyle(
                  fontSize: screenWidth * 0.0375, // Dynamically scale font size (15px for a 400px width screen)
                  fontWeight: FontWeight.w600, // Semi-bold font weight
                  color: Color(0xFF989DA3), // #989DA3 color
                  fontFamily: 'Product Sans', // Product Sans font
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}