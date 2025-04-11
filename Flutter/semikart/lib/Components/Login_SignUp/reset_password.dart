import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For status bar customization
import 'forgot_password.dart'; // Import the ForgotPasswordScreen
import 'confirm_password.dart'; // Import the ConfirmPasswordScreen
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/inactive_red_button.dart'; // Import the InactiveRedButton widget
import 'success.dart'; // Import the SuccessScreen

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool passwordsMatch = false; // Track if passwords match

  @override
  Widget build(BuildContext context) {
    // Set the status bar to have a white background with black content
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // White background for the status bar
      statusBarIconBrightness: Brightness.dark, // Black content for the status bar
    ));

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Add horizontal padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05), // Add spacing at the top

              // Row for Back Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFFA51414)), // Back arrow icon
                    iconSize: screenWidth * 0.06, // Dynamically scale the icon size
                    onPressed: () {
                      // Navigate back to ForgotPasswordScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02), // Add spacing below the back button

              // ResetMan Image
              Center(
                child: Image.asset(
                  'public/assets/images/resetman.png', // Replace with the actual path to resetman.png
                  width: screenWidth * 0.5, // Dynamically scale width
                  height: screenHeight * 0.25, // Dynamically scale height
                  fit: BoxFit.contain, // Ensure the image fits within the bounds
                ),
              ),

              SizedBox(height: screenHeight * 0.02), // Add spacing below the image

              // "Set Your Password" Text
              Center(
                child: Text(
                  "Set Your Password",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06, // Dynamically scale font size
                    fontWeight: FontWeight.bold, // Bold font weight
                    color: Colors.black, // Black color
                    fontFamily: 'Product Sans', // Product Sans font
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.01), // Add spacing below the title

              // Instruction Text
              Center(
                child: Text(
                  "In order to keep your account safe you need\n"
                  "to create a strong password.",
                  textAlign: TextAlign.center, // Center align the text
                  style: TextStyle(
                    fontSize: screenWidth * 0.045, // Dynamically scale font size
                    fontWeight: FontWeight.w400, // Regular font weight
                    color: Color(0xFF989DA3), // Subtle grey color
                    fontFamily: 'Product Sans', // Product Sans font
                    height: 1.5, // Line height for better readability
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03), // Add spacing below the instruction text

              // Confirm Password Component
              ConfirmPasswordScreen(
                width: screenWidth * 0.9, // 90% of screen width
                height: screenHeight * 0.06, // Dynamically scale height
                onPasswordsMatch: (match) {
                  setState(() {
                    passwordsMatch = match; // Update the passwordsMatch state
                  });
                },
              ),

              SizedBox(height: screenHeight * 0.03), // Add spacing below the ConfirmPasswordScreen

              // Confirm Button
              Center(
                child: passwordsMatch
                    ? RedButton(
                        label: "Confirm", // Button label
                        width: screenWidth * 0.9, // Dynamically scale width
                        height: screenHeight * 0.06, // Dynamically scale height
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SuccessScreen()), // Navigate to SuccessScreen
                          );
                        },
                      )
                    : InactiveButton(
                        label: "Confirm", // Button label
                        width: screenWidth * 0.9, // Dynamically scale width
                        height: screenHeight * 0.06, // Dynamically scale height
                      ),
              ),

              SizedBox(height: screenHeight * 0.03), // Add spacing below the button
            ],
          ),
        ),
      ),
    );
  }
}