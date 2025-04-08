import 'package:flutter/material.dart';
import '../common/signinwith_google.dart';
import 'custom_text_field.dart';
import 'password_text_field.dart'; // Import the PasswordTextField widget

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView( // Enable scrolling
        child: Container(
          width: double.infinity, // Dynamically takes the full width of the screen
          height: screenHeight * 1.2, // Extend height to fit all components
          color: Colors.white, // Set the background color to white
          child: Stack(
            children: [
              // Semikart Logo
              Positioned(
                left: screenWidth * 0.06, // 6% of screen width
                top: screenHeight * 0.10, // 10% of screen height
                child: Image.asset(
                  'public/assets/images/Semikart_Logo_Medium.png', // Path to the logo
                  width: screenWidth * 0.5, // 50% of screen width
                  height: screenHeight * 0.04, // 4% of screen height
                  fit: BoxFit.contain, // Ensure the image fits within the dimensions
                ),
              ),

              // "Create Your Account" Text
              Positioned(
                left: screenWidth * 0.09, // 9% of screen width
                top: screenHeight * 0.20, // 20% of screen height
                child: Text(
                  'Create your account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06, // 6% of screen width
                    fontFamily: 'Product Sans', // Product Sans font
                    color: Colors.black, // Black color
                    fontWeight: FontWeight.normal, // Regular weight
                  ),
                ),
              ),

              // Centered SignInWithGoogleButton
              Positioned(
                top: screenHeight * 0.28, // 28% of screen height
                left: 0, // Start from the left edge
                right: 0, // End at the right edge
                child: Center(
                  child: SignInWithGoogleButton(
                    onPressed: () {
                      // Handle the Google sign-in logic here
                      print('Google Sign-In button pressed');
                    },
                    isLoading: false, // Set to true if loading state is required
                  ),
                ),
              ),

              // First horizontal black line
              Positioned(
                left: screenWidth * 0.09, // 9% of screen width
                top: screenHeight * 0.42, // 42% of screen height
                child: Container(
                  width: screenWidth * 0.4, // 40% of screen width
                  height: 1, // Fixed height
                  color: Colors.black, // Line color
                ),
              ),

              // Positioned "OR" text exactly in the middle
              Positioned(
                left: screenWidth * 0.50, // Centered between the two lines
                top: screenHeight * 0.405, // Slightly above the lines
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

              // Second horizontal black line
              Positioned(
                left: screenWidth * 0.57, // 57% of screen width
                top: screenHeight * 0.42, // 42% of screen height
                child: Container(
                  width: screenWidth * 0.4, // 40% of screen width
                  height: 1, // Fixed height
                  color: Colors.black, // Line color
                ),
              ),

              // Positioned CustomTextField for First Name
              Positioned(
                left: screenWidth * 0.06, // Align with other components
                top: screenHeight * 0.48, // Adjust position to align with layout
                child: CustomTextField(
                  controller: TextEditingController(), // Provide a controller
                  label: "FirstName", // Set the label to "FirstName"
                ),
              ),

              // Positioned CustomTextField for Last Name
              Positioned(
                left: screenWidth * 0.06, // Align with other components
                top: screenHeight * 0.58, // Adjust position to align with layout
                child: CustomTextField(
                  controller: TextEditingController(), // Provide a controller
                  label: "LastName", // Set the label to "LastName"
                ),
              ),

              // Positioned CustomTextField for Email
              Positioned(
                left: screenWidth * 0.06, // Align with other components
                top: screenHeight * 0.68, // Adjust position to align with layout
                child: CustomTextField(
                  controller: TextEditingController(), // Provide a controller
                  label: "Email", // Set the label to "Email"
                ),
              ),

              // Positioned CustomTextField for Company Name
              Positioned(
                left: screenWidth * 0.06, // Align with other components
                top: screenHeight * 0.88, // Adjust position to align with layout
                child: CustomTextField(
                  controller: TextEditingController(), // Provide a controller
                  label: "Company Name", // Set the label to "Company Name"
                ),
              ),

              // Positioned PasswordTextField for Password
              Positioned(
                left: screenWidth * 0.06, // Align with other components
                top: screenHeight * 0.98, // Adjust position to align with layout
                child: PasswordTextField(
                  controller: TextEditingController(), // Provide a controller
                  label: "Password", // Set the label to "Password"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}