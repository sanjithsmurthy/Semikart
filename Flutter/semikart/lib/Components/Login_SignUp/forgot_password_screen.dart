import 'package:flutter/material.dart';
import 'Loginpassword.dart'; // Import the LoginPasswordScreen
import 'signupscreen.dart'; // Import the SignUpScreen
import 'reset_password.dart'; // Import the ResetPasswordScreen
import 'custom_text_field.dart'; // Import the CustomTextField widget
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/popup.dart'; // Import the CustomPopup widget

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(); // Controller for email input

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
            left: screenWidth * 0.055, // 30px from the left
            top: screenHeight * 0.06, // 40px from the top
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFFA51414)), // Left-facing V icon
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
            top: screenHeight * 0.1625, // 130px from the top (130 / 800 = 0.1625 for an 800px height screen)
            left: screenWidth * 0.055, // 22px from the left (22 / 400 = 0.055 for a 400px width screen)
            child: Text(
              "Forgot Password",
              style: TextStyle(
                fontSize: screenWidth * 0.07, // Slightly larger font size for a classy look
                fontWeight: FontWeight.w600, // Semi-bold weight for emphasis
                color: Colors.black, // Black color for a clean look
                fontFamily: 'Product Sans', // Product Sans font
              ),
            ),
          ),

          // Instruction Text
          Positioned(
            top: screenHeight * 0.23, // Just below the "Forgot Password" title
            left: screenWidth * 0.055, // 22px from the left
            right: screenWidth * 0.055, // 22px from the right
            child: Text(
              "Enter your registered email address. You will receive a link to create a new password via email.",
              style: TextStyle(
                fontSize: screenWidth * 0.045, // Dynamically scale font size (18px for a 400px width screen)
                fontWeight: FontWeight.w400, // Regular weight for a clean and professional look
                color: Color(0xFFb6b6b6), // Slightly darker grey for a subtle appearance
                fontFamily: 'Product Sans', // Product Sans font
                height: 1.5, // Line height for better readability
              ),
              textAlign: TextAlign.left, // Justify text for a polished look
            ),
          ),

          // Email Input Field (Using CustomTextField)
          Positioned(
            top: screenHeight * 0.38, // 35% of screen height
            left: screenWidth * 0.05, // 5% of screen width
            right: screenWidth * 0.05, // 5% of screen width
            child: CustomTextField(
              controller: emailController,
              label: "Email", // Label for the email field
            ),
          ),

          // Send Reset Link Button (Using RedButton)
          Positioned(
            top: screenHeight * 0.59, // 472px from the top (472 / 800 = 0.59 for an 800px height screen)
            left: screenWidth * 0.055, // 35px from the left
            right: screenWidth * 0.055, // 35px from the right
            child: RedButton(
              label: "Send Reset Link", // Button label
              width: screenWidth * 0.825, // Dynamically scale width (330px for a 400px width screen)
              height: screenHeight * 0.06, // Dynamically scale height (48px for an 800px height screen)
              onPressed: () async {
                // Simulate checking the email in the database
                String email = emailController.text.trim();
                bool emailExists = _checkEmailInDatabase(email); // Simulated database check

                if (!emailExists) {
                  // Show popup if email is not found
                  await CustomPopup.show(
                    context: context,
                    title: 'Email Not Found',
                    message: "Don't have an account.",
                    buttonText: 'SignUp',
                    imagePath: 'public/assets/images/Alert.png', // Optional image path
                  ).then((_) {
                    // Navigate to SignUpScreen when popup button is clicked
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  });
                } else {
                  // Navigate to ResetPasswordScreen if email exists
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Simulated function to check if the email exists in the database
  bool _checkEmailInDatabase(String email) {
    // Simulate a database with a list of registered emails
    List<String> registeredEmails = ["user1@example.com", "user2@example.com", "user3@example.com"];
    return registeredEmails.contains(email);
  }
}