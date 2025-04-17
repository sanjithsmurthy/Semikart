import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For status bar customization
import 'login_password_new.dart'; // Import the LoginPasswordScreen
import 'signup_screen.dart'; // Import the SignUpScreen
import 'reset_password.dart'; // Import the ResetPasswordScreen
import 'custom_text_field.dart'; // Import the CustomTextField widget
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/popup.dart'; // Import the CustomPopup widget

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(); // Controller for email input

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

              // Back Button
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFFA51414)), // Left-facing arrow icon
                iconSize: screenWidth * 0.06, // Dynamically scale the icon size
                onPressed: () {
                  // Navigate back to LoginPasswordScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPasswordNewScreen()),
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.02), // Add spacing below the back button

              // Forgot Password Title
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: screenWidth * 0.07, // Dynamically scale font size
                  fontWeight: FontWeight.w600, // Semi-bold weight for emphasis
                  color: Colors.black, // Black color for a clean look
                   // Product Sans font
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Add spacing below the title

              // Instruction Text
              Text(
                "Enter your registered email address. You will receive a link to create a new password via email.",
                style: TextStyle(
                  fontSize: screenWidth * 0.045, // Dynamically scale font size
                  fontWeight: FontWeight.w400, // Regular weight for a clean and professional look
                  color: Color(0xFFb6b6b6), // Subtle grey color for instructions
                   // Product Sans font
                  height: 1.5, // Line height for better readability
                ),
                textAlign: TextAlign.left, // Align text to the left
              ),
              SizedBox(height: screenHeight * 0.04), // Add spacing below the instructions

              // Email Input Field (Using CustomTextField)
              CustomTextField(
                controller: emailController,
                label: "Email", // Label for the email field
                width: screenWidth * 0.9, // Dynamically scale width
                height: screenHeight * 0.06, // Dynamically scale height
              ),
              SizedBox(height: screenHeight * 0.04), // Add spacing below the email field

              // Send Reset Link Button (Using RedButton)
              RedButton(
                label: "Send Reset Link", // Button label
                width: screenWidth * 0.9, // Dynamically scale width
                height: screenHeight * 0.06, // Dynamically scale height
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
            ],
          ),
        ),
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