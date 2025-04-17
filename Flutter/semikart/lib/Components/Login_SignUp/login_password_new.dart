import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this package
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import 'horizontal_radios.dart'; // Import the HorizontalRadios widget
import 'custom_text_field.dart'; // Import the CustomTextField widget
import 'password_text_field.dart'; // Import the PasswordTextField widget
import '../common/forgot_password.dart'; // Import the ForgotPasswordButton widget
import '../common/red_button.dart'; // Import the RedButton widget
import 'signup_screen.dart'; // Import the SignUpScreen widget
import 'forgot_password.dart'; // Import the ForgotPassword screen

class LoginPasswordNewScreen extends StatelessWidget { // Renamed the class
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // White background
            Container(
              width: screenWidth,
              height: screenHeight,
              color: Colors.white, // Set the background color to white
            ),

            // Positioned Semikart logo
            Positioned(
              left: screenWidth * 0.05, // 5% of screen width
              top: screenHeight * 0.08, // 8% of screen height
              child: Image.asset(
                'public/assets/images/semikart_logo_medium.png', // Path to the logo
                width: screenWidth * 0.4, // 40% of screen width
                height: screenHeight * 0.05, // 5% of screen height
                fit: BoxFit.contain, // Ensure the image fits within the dimensions
              ),
            ),

            // Positioned Login text
            Positioned(
              left: screenWidth * 0.05, // 5% of screen width
              top: screenHeight * 0.18, // 18% of screen height
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: screenWidth * 0.055, // 5.5% of screen width
                   // Product Sans font
                  color: Colors.black, // Black color
                  fontWeight: FontWeight.bold, // Bold weight
                ),
              ),
            ),

            // Centered SignInWithGoogleButton
            Positioned(
              left: screenWidth * 0.05, // 5% of screen width
              right: screenWidth * 0.05, // 5% padding on both sides
              top: screenHeight * 0.23, // 25% of screen height
              child: Center(
                child: SignInWithGoogleButton(
                  onPressed: () {
                    // Handle the Google sign-in logic here
                    print('Google Sign-In button pressed');
                  },
                  isLoading: false, // Set to true if loading state is required
                   // Display the text in two lines
                ),
              ),
            ),

            // HorizontalRadios below Google Sign-In button
            Positioned(
              left: screenWidth * 0.05, // 5% of screen width
              right: screenWidth * 0.05, // 5% padding on both sides
              top: screenHeight * 0.33, // 35% of screen height
              child: Center(
                child: HorizontalRadios(
                  initialOption: "password", // Set the initial selected option
                ),
              ),
            ),

            // Positioned CustomTextField for Email
            Positioned(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05, // 5% padding on both sides
              top: screenHeight * 0.45, // 45% of screen height
              child: CustomTextField(
                controller: TextEditingController(),
                width: screenWidth, // Provide a controller
                label: "Email", // Set the label to "Email"
                height: screenHeight * 0.06, // 6% of screen height
              ),
            ),

            // Positioned PasswordTextField for Password
            Positioned(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05, // 5% padding on both sides
              top: screenHeight * 0.55, // 55% of screen height
              child: PasswordTextField(
                controller: TextEditingController(),
                width: screenWidth * 1, // Provide a controller
                label: "Password", // Set the label to "Password"
                height: screenHeight * 0.06, // 6% of screen height
              ),
            ),

            // Positioned ForgotPasswordButton
            Positioned(
              right: screenWidth * 0.05, // 5% of screen width
              top: screenHeight * 0.65, // 65% of screen height
              child: ForgotPasswordButton(
                label: "Forgot Password?", // Set the label
                onPressed: () {
                  // Navigate to ForgotPassword screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                  );
                },
              ),
            ),

            // Positioned "Don't have an account?" Button
            Positioned(
              right: screenWidth * 0.05, // 5% of screen width
              top: screenHeight * 0.70, // 70% of screen height
              child: ForgotPasswordButton(
                label: "Don't have an account?", // Set the label
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
              ),
            ),

            // Positioned RedButton for Login
            Positioned(
              left: screenWidth * 0.05, // 5% of screen width
              top: screenHeight * 0.785, // 78.5% of screen height
              child: RedButton(
                label: "Login", // Set the label to "Login"
                width: screenWidth * 0.90, // 90% of screen width
                height: screenHeight * 0.06, // 6% of screen height
                onPressed: () {
                  // Handle the Login button click
                  print('Login button clicked');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}