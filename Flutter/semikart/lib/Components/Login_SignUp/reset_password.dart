import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

          // Shield with Red Tick and Person Icon
          Positioned(
            top: screenHeight * 0.15, // Adjust top padding dynamically
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Shield Icon
                Icon(
                  Icons.shield, // Shield icon
                  color: Color(0xFF707070), // Grey color for the shield
                  size: screenWidth * 0.3, // Dynamically scale the shield size
                ),

                // Red Tick in the Middle of the Shield
                Icon(
                  Icons.check, // Red tick icon
                  color: Color(0xFFA51414), // Red color for the tick
                  size: screenWidth * 0.1, // Dynamically scale the tick size
                ),

                // Person Icon (Pointing)
                Positioned(
                  right: -screenWidth * 0.1, // Adjust position to the right of the shield
                  bottom: -screenHeight * 0.05, // Slightly below the shield
                  child: FaIcon(
                    FontAwesomeIcons.personWalkingArrowRight, // Person pointing icon
                    color: Color(0xFFA51414), // Red color for the person icon
                    size: screenWidth * 0.15, // Dynamically scale the person icon size
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}