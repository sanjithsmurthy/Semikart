import 'package:flutter/material.dart';
import '../common/signinwith_google.dart';
import 'custom_text_field.dart'; // Import the CustomTextField widget

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity, // Dynamically takes the full width of the screen
        height: double.infinity, // Dynamically takes the full height of the screen
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
              top: screenHeight * 0.24, // 24% of screen height
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
              top: screenHeight * 0.32, // 32% of screen height
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
            top: screenHeight * 0.46, // 46% of screen height
            child: Container(
              width: screenWidth * 0.4, // 40% of screen width
              height: 1, // Fixed height
              color: Colors.black, // Line color
            ),
          ),

          // Positioned "OR" text exactly in the middle
          Positioned(
            left: screenWidth * 0.50, // Centered between the two lines
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

          // Second horizontal black line
          Positioned(
            left: screenWidth * 0.57, // 51% of screen width
            top: screenHeight * 0.46, // 46% of screen height
            child: Container(
              width: screenWidth * 0.4, // 40% of screen width
              height: 1, // Fixed height
              color: Colors.black, // Line color
            ),
          ),

          // Positioned CustomTextField for Email
          Positioned(
            left: screenWidth * 0.06, // Align with other components
            top: screenHeight * 0.52, // Adjust position to align with layout
            child: CustomTextField(
              controller: TextEditingController(), // Provide a controller
              label: "FirstName", // Set the label to "Email"
            ),
          ),  


          Positioned(
            left: screenWidth * 0.06, // Align with other components
            top: screenHeight * 0.62, // Adjust position to align with layout
            child: CustomTextField(
              controller: TextEditingController(), // Provide a controller
              label: "LastName", // Set the label to "Email"
            ),
          ),  


           Positioned(
            left: screenWidth * 0.06, // Align with other components
            top: screenHeight * 0.72, // Adjust position to align with layout
            child: CustomTextField(
              controller: TextEditingController(), // Provide a controller
              label: "Email", // Set the label to "Email"
            ),
          ),  

          ],
        ),
      ),
    );
  }
}