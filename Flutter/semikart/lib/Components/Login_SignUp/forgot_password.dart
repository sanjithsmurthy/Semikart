import 'package:flutter/material.dart';
import 'Loginpassword.dart'; // Import the LoginPasswordScreen

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // White background
          Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.white, // Set the background color to white
          ),

          // Back Button
          Positioned(
            left: screenWidth * 0.075, // 30px from the left (30 / 400 = 0.075 for a 400px width screen)
            top: screenHeight * 0.05, // 40px from the top (40 / 800 = 0.05 for an 800px height screen)
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
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

          // Forgot Password Title
          Positioned(
            top: screenHeight * 0.15, // 15% of screen height
            left: screenWidth * 0.05, // 5% of screen width
            child: Text(
              "Forgot Password",
              style: TextStyle(
                fontSize: screenWidth * 0.08, // Dynamically scale font size
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Product Sans',
              ),
            ),
          ),

          // Instruction Text
          Positioned(
            top: screenHeight * 0.22, // 22% of screen height
            left: screenWidth * 0.05, // 5% of screen width
            right: screenWidth * 0.05, // 5% of screen width
            child: Text(
              "Enter your registered email address to receive a password reset link.",
              style: TextStyle(
                fontSize: screenWidth * 0.045, // Dynamically scale font size
                color: Colors.black54,
                fontFamily: 'Product Sans',
              ),
            ),
          ),

          // Email Input Field
          Positioned(
            top: screenHeight * 0.35, // 35% of screen height
            left: screenWidth * 0.05, // 5% of screen width
            right: screenWidth * 0.05, // 5% of screen width
            child: TextField(
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: screenWidth * 0.045, // Dynamically scale font size
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Send Reset Link Button
          Positioned(
            top: screenHeight * 0.45, // 45% of screen height
            left: screenWidth * 0.05, // 5% of screen width
            right: screenWidth * 0.05, // 5% of screen width
            child: ElevatedButton(
              onPressed: () {
                // Handle sending the reset link
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Password reset link sent to your email."),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA51414), // Red color
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // Dynamically scale padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Send Reset Link",
                style: TextStyle(
                  fontSize: screenWidth * 0.05, // Dynamically scale font size
                  color: Colors.white,
                  fontFamily: 'Product Sans',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}