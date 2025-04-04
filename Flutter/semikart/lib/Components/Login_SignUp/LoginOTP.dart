import 'package:flutter/material.dart';
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import '../common/vertical_radios.dart'; // Import the VerticalRadios widget
import '../common/custom_text_field.dart'; // Import the CustomTextField widget
import '../common/password_text_field.dart'; // Import the PasswordTextField widget
import '../common/forgot_password.dart'; // Import the ForgotPasswordButton widget
import '../common/red_button.dart'; // Import the RedButton widget

class LoginOTPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
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

          // Positioned Semikart logo
          Positioned(
            left: screenWidth * 0.09, // 9% of screen width
            top: screenHeight * 0.14, // 14% of screen height
            child: Image.asset(
              'public/assets/images/Semikart_Logo_Medium.png', // Path to the logo
              width: screenWidth * 0.5, // 50% of screen width
              height: screenHeight * 0.04, // 4% of screen height
              fit: BoxFit.contain, // Ensure the image fits within the dimensions
            ),
          ),

          // Positioned Login text
          Positioned(
            left: screenWidth * 0.09, // 9% of screen width
            top: screenHeight * 0.24, // 24% of screen height
            child: Text(
              'Login with OTP',
              style: TextStyle(
                fontSize: screenWidth * 0.06, // 6% of screen width
                fontFamily: 'Product Sans', // Product Sans font
                color: Colors.black, // Black color
                fontWeight: FontWeight.normal, // Regular weight
              ),
            ),
          ),

          // Positioned SignInWithGoogleButton
          Positioned(
            left: screenWidth * 0.07, // 7% of screen width
            top: screenHeight * 0.33, // 33% of screen height
            child: SignInWithGoogleButton(
              onPressed: () {
                // Handle the Google sign-in logic here
                print('Google Sign-In button pressed');
              },
              isLoading: false, // Set to true if loading state is required
              isTwoLine: true, // Display the text in two lines
            ),
          ),

          // Positioned VerticalRadios
          Positioned(
            left: screenWidth * 0.65, // 65% of screen width
            top: screenHeight * 0.33, // 33% of screen height
            child: VerticalRadios(), // Display the VerticalRadios widget
          ),

          // First horizontal black line
          Positioned(
            left: screenWidth * 0.09, // 9% of screen width
            top: screenHeight * 0.46, // 46% of screen height
            child: Container(
              width: screenWidth * 0.4 - 10, // Subtract 10px for spacing near "OR"
              height: 1, // Fixed height
              color: Colors.black, // Line color
            ),
          ),

          // Second horizontal black line
          Positioned(
            left: screenWidth * 0.51 + 10, // Add 10px for spacing near "OR"
            top: screenHeight * 0.46, // 46% of screen height
            child: Container(
              width: screenWidth * 0.4 - 10, // Subtract 10px for spacing near "OR"
              height: 1, // Fixed height
              color: Colors.black, // Line color
            ),
          ),

          // Positioned "OR" text exactly in the middle
          Positioned(
            left: screenWidth * 0.45, // Centered between the two lines
            top: screenHeight * 0.445, // Slightly above the lines
            child: Text(
              'OR',
              style: TextStyle(
                fontSize: screenWidth * 0.04, // 4% of screen width
                fontFamily: 'Product Sans', // Product Sans font
                color: Colors.black, // Black color
                fontWeight: FontWeight.normal, // Regular weight
              ),
            ),
          ),

          // Positioned CustomTextField for Mobile Number
          Positioned(
            left: screenWidth * 0.06, // 6% of screen width
            top: screenHeight * 0.52, // 52% of screen height
            child: CustomTextField(
              controller: TextEditingController(), // Provide a controller
              label: "Mobile Number", // Set the label to "Mobile Number"
            ),
          ),

          // Positioned RedButton for Login with OTP
          Positioned(
            left: screenWidth * 0.09, // 9% of screen width
            top: screenHeight * 0.65, // 65% of screen height
            child: RedButton(
              label: "Send OTP", // Set the label to "Send OTP"
              width: screenWidth * 0.85, // 85% of screen width
              height: screenHeight * 0.06, // 6% of screen height
              onPressed: () {
                // Handle the Send OTP button click
                print('Send OTP button clicked');
              },
            ),
          ),
        ],
      ),
    );
  }
}