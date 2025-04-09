import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this package
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import 'vertical_radios.dart'; // Import the VerticalRadios widget
import 'custom_text_field.dart'; // Import the CustomTextField widget
import '../common/forgot_password.dart';
import '../common/red_button.dart'; // Import the ForgotPasswordButton widget
import 'Loginpassword.dart'; // Import the LoginPassword screen
import 'signupscreen.dart';// Import the LoginOTP screen

class LoginOTPScreen extends StatefulWidget {
  @override
  _LoginOTPScreenState createState() => _LoginOTPScreenState();
}

class _LoginOTPScreenState extends State<LoginOTPScreen> {
  bool canSendOTP = true;
  int countdown = 0;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set the status bar background color to white
      statusBarIconBrightness: Brightness.dark, // Set the status bar icons to dark
    ));

    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea( // Wrap the Stack in SafeArea
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
              left: screenWidth * 0.05, // 9% of screen width
              top: screenHeight * 0.10, // 14% of screen height
              child: Image.asset(
                'public/assets/images/semikart_logo_medium.png', // Path to the logo
                width: screenWidth * 0.5, // 50% of screen width
                height: screenHeight * 0.04, // 4% of screen height
                fit: BoxFit.contain, // Ensure the image fits within the dimensions
              ),
            ),

            // Positioned Login text
            Positioned(
              left: screenWidth * 0.05, // 9% of screen width
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
              left: screenWidth * 0.05, // 7% of screen width
              top: screenHeight * 0.32, // 32% of screen height
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
              left: screenWidth * 0.48, // 65% of screen width
              top: screenHeight * 0.25, // 33% of screen height
              child: VerticalRadios(
                initialOption: "otp"
                
              ),
            ),


            // First horizontal black line
            Positioned(
              left: screenWidth * 0.05, // 9% of screen width
              top: screenHeight * 0.46, // 46% of screen height
              child: Container(
                width: screenWidth * 0.4, // 40% of screen width
                height: 1, // Fixed height
                color: Colors.black, // Line color
              ),
            ),

            // Positioned "OR" text exactly in the middle
            Positioned(
              left: screenWidth * 0.48, // Centered between the two lines
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
              right: screenWidth * 0.05, // 51% of screen width
              top: screenHeight * 0.46, // 46% of screen height
              child: Container(
                width: screenWidth * 0.4, // 40% of screen width
                height: 1, // Fixed height
                color: Colors.black, // Line color
              ),
            ),

            // Positioned CustomTextField for Email
            Positioned(
              left: screenWidth * 0.05,
              right: screenWidth*0.05, // Align with other components
              top: screenHeight * 0.52, // Adjust position to align with layout
              child: CustomTextField(
                controller: TextEditingController(), // Provide a controller
                label: "Email", // Set the label to "Email"
              ),
            ),

            // OTP Section
            Positioned(
              left: screenWidth * 0.05,
              right: screenWidth*0.05, // Align with other components
              top: screenHeight * 0.65, // Adjust position to align with layout
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8), // Space between "Send OTP" and the text field

                  // OTP Input Field
                  CustomTextField(
                    controller: TextEditingController(), // Provide a controller
                    label: "OTP", // Set the label to "OTP"
                  ),
                ],
              ),
            ),

            // Positioned Send OTP
            Positioned(
              left: screenWidth * 0.65, // Align with other components
              top: screenHeight * 0.73, // Adjust position to align with layout
              child: GestureDetector(
                onTap: () {
                  if (canSendOTP) {
                    setState(() {
                      canSendOTP = false; // Disable the "Send OTP" button
                      countdown = 120; // Start the 2-minute timer (120 seconds)
                    });

                    // Start the countdown timer
                    timer = Timer.periodic(Duration(seconds: 1), (timer) {
                      if (countdown > 0) {
                        setState(() {
                          countdown--;
                        });
                      } else {
                        timer.cancel(); // Stop the timer when it reaches 0
                        setState(() {
                          canSendOTP = true; // Re-enable the "Send OTP" button
                        });
                      }
                    });
                  }
                },
                child: Text(
                  canSendOTP
                      ? 'Send OTP'
                      : 'Resend OTP in ${countdown ~/ 60}:${(countdown % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Product Sans',
                    color: canSendOTP ? Colors.black : Colors.grey, // Grey when disabled
                  ),
                ),
              ),
            ),

            // Positioned "Don't have an account?" Button
            Positioned(
              right: screenWidth * 0.05, // 58% - 10% of screen width
              top: screenHeight * 0.82, // 82% of screen height
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
              left: screenWidth * 0.05, // 9% of screen width
              top: screenHeight * 0.9, // 90% of screen height
              child: RedButton(
                label: "Login", // Set the label to "Login"
                width: screenWidth * 0.85, // 85% of screen width
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