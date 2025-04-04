import 'package:flutter/material.dart';
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import '../common/vertical_radios.dart'; // Import the VerticalRadios widget
import '../common/custom_text_field.dart'; // Import the CustomTextField widget
import '../common/otp_text_field.dart'; // Import the updated OTPTextField
import '../common/forgot_password.dart'; // Import the ForgotPasswordButton widget

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
              'Login',
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

          // Positioned CustomTextField for Email
          Positioned(
            left: screenWidth * 0.06, // 6% of screen width
            top: screenHeight * 0.52, // 52% of screen height
            child: CustomTextField(
              controller: TextEditingController(), // Provide a controller
              label: "Email", // Set the label to "Email"
            ),
          ),

          // OTP Section
          Positioned(
            left: screenWidth * 0.06, // 6% of screen width
            top: screenHeight * 0.65, // 65% of screen height
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter OTP',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Product Sans',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                OTPTextField(
                  controller: TextEditingController(), // Provide a controller
                  label: "Enter OTP", // Label for the OTP field
                  onChanged: (otp) {
                    // Handle the OTP change
                  },
                ),
                SizedBox(height: 32),
              ],
            ),
          ),

          // Positioned ForgotPasswordButton
          Positioned(
            left: screenWidth * 0.6, // 70% - 10% of screen width
            top: screenHeight * 0.78, // 78% of screen height
            child: ForgotPasswordButton(
              label: "Forgot Password", // Set the label
              onPressed: () {
                // Handle the Forgot Password button click
                print('Forgot Password button clicked');
              },
            ),
          ),

          // Positioned "Don't have an account?" Button
          Positioned(
            left: screenWidth * 0.48, // 58% - 10% of screen width
            top: screenHeight * 0.82, // 82% of screen height
            child: ForgotPasswordButton(
              label: "Don't have an account?", // Set the label
              onPressed: () {
                // Handle the button click
                print('Don\'t have an account button clicked');
              },
            ),
          ),

          // Positioned RedButton for Login
          Positioned(
            left: screenWidth * 0.09, // 9% of screen width
            top: screenHeight * 0.9, // 90% of screen height
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Button color
                minimumSize: Size(screenWidth * 0.85, screenHeight * 0.06), // Button size
              ),
              onPressed: () {
                // Handle the Login button click
                print('Login button clicked');
              },
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: screenWidth * 0.045, // 4.5% of screen width
                  fontFamily: 'Product Sans',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}