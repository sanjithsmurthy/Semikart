import 'package:flutter/material.dart';
import 'Loginpassword.dart'; // Import the LoginPasswordScreen
import 'forgot_password.dart'; // Import the ForgotPasswordScreen
import 'confirm_password.dart'; // Import the ConfirmPasswordScreen
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/inactive_red_button.dart'; // Import the InactiveRedButton widget

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool passwordsMatch = false; // Track if passwords match

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView( // Make the layout scrollable
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Add horizontal padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.0375), // Leave only 30px gap at the top dynamically

              // Row for Back Button and Cross Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align icons at opposite ends
                children: [
                  // Back Button
                  IconButton(
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

                  // Cross Icon
                  IconButton(
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
                ],
              ),

              SizedBox(height: screenHeight * 0.015), // Add spacing below the icons

              // ResetMan Image
              Center(
                child: Image.asset(
                  'public/assets/images/resetman.png', // Replace with the actual path to resetman.png
                  width: screenWidth * 0.5, // Dynamically scale width
                  height: screenHeight * 0.25, // Dynamically scale height
                  fit: BoxFit.contain, // Ensure the image fits within the bounds
                ),
              ),

              SizedBox(height: screenHeight * 0.01), // Add spacing below the image

              // "Set Your Password" Text
              Center(
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

              SizedBox(height: screenHeight * 0.005), // Reduced spacing below the title

              // Instruction Text
              Center(
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

              SizedBox(height: screenHeight * 0.005), // Reduced spacing below the instruction text to push ConfirmPasswordScreen upwards

              // Confirm Password Component
              ConfirmPasswordScreen(
                onPasswordsMatch: (match) {
                  setState(() {
                    passwordsMatch = match; // Update the passwordsMatch state
                  });
                },
              ),

              SizedBox(height: screenHeight * 0.01), // Reduced spacing below the ConfirmPasswordScreen

              // Button
              Center(
                child: passwordsMatch
                    ? RedButton(
                        label: "Confirm", // Button label
                        width: screenWidth * 0.9, // Dynamically scale width
                        height: screenHeight * 0.06, // Dynamically scale height
                        onPressed: () {
                          // Handle submit action
                          print("Passwords match! Proceeding...");
                        },
                      )
                    : InactiveButton(
                        label: "Confirm", // Button label
                        width: screenWidth * 0.9, // Dynamically scale width
                        height: screenHeight * 0.06, // Dynamically scale height
                      ),
              ),

              SizedBox(height: screenHeight * 0.02), // Add spacing below the button
            ],
          ),
        ),
      ),
    );
  }
}