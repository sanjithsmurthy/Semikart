import 'package:flutter/material.dart';
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import '../common/vertical_radios.dart'; // Import the VerticalRadios widget

class LoginPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
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
            left: 36, // 36 from the left
            top: 113, // 113 from the top
            child: Image.asset(
              'public/assets/images/Semikart_Logo_Medium.png', // Path to the logo
              width: 190, // Set the width to 190
              height: 28, // Set the height to 28
              fit: BoxFit.contain, // Ensure the image fits within the dimensions
            ),
          ),

          // Positioned Login text
          Positioned(
            left: 36, // 36 from the left
            top: 197, // 197 from the top
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 25, // Font size 25
                fontFamily: 'Product Sans', // Product Sans font
                color: Colors.black, // Black color
                fontWeight: FontWeight.normal, // Regular weight
              ),
            ),
          ),

          // Positioned SignInWithGoogleButton
          Positioned(
            left: 28, // 28 from the left
            top: 263, // 263 from the top
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
            left: 250, // 150 from the left
            top: 252, // 252 from the top
            child: VerticalRadios(), // Display the VerticalRadios widget
          ),

          // First horizontal line
          Positioned(
            left: 33.5, // 33.5 from the left
            top: 370, // 370 from the top
            child: Container(
              width: 151, // Width of the line
              height: 1, // Height of the line
              color: Colors.black, // Line color
            ),
          ),

          // Second horizontal line
          Positioned(
            left: 227.5, // 227.5 from the left
            top: 370, // 370 from the top
            child: Container(
              width: 151, // Width of the line
              height: 1, // Height of the line
              color: Colors.black, // Line color
            ),
          ),
        ],
      ),
    );
  }
}