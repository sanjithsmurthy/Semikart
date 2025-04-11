import 'dart:async';
import 'package:flutter/material.dart';
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import 'vertical_radios.dart'; // Import the VerticalRadios widget
import 'custom_text_field.dart'; // Import the CustomTextField widget
import '../common/forgot_password.dart';
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/inactive_red_button.dart'; // Import the InactiveButton widget
import 'signupscreen.dart'; // Import the SignUpScreen
import '../common/popup.dart'; // Import the CustomPopup widget

class LoginOTPScreen extends StatefulWidget {
  @override
  _LoginOTPScreenState createState() => _LoginOTPScreenState();
}

class _LoginOTPScreenState extends State<LoginOTPScreen> {
  bool canSendOTP = false; // Initially, the Generate OTP button is inactive
  int countdown = 0; // Countdown timer in seconds
  Timer? timer;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController(); // Controller for OTP input
  bool isEmailValid = false; // State to track email validity

  // Temporary database of email IDs
  final List<String> emailDatabase = [
    "test1@example.com",
    "user2@example.com",
    "admin@example.com",
    "demo@example.com"
  ];

  // Hardcoded OTP for now
  final String correctOTP = "123456";

  // Validate email against the temporary database
  void _validateEmail(String email) {
    setState(() {
      isEmailValid = emailDatabase.contains(email); // Check if email exists in the database
      canSendOTP = isEmailValid; // Enable Generate OTP button if email is valid
    });
  }

  // Start the OTP resend timer
  void _startTimer() {
    setState(() {
      canSendOTP = false; // Disable OTP generation while the timer is running
      countdown = 90; // Reset the timer to 1:30 (90 seconds)
    });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--; // Decrement the timer
        } else {
          timer.cancel(); // Stop the timer
          canSendOTP = isEmailValid; // Enable OTP generation if email is valid
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Adjust layout when the keyboard appears
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Adjust padding for the keyboard
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.08), // Top spacing
                // Semikart Logo
                Center(
                  child: Image.asset(
                    'public/assets/images/semikart_logo_medium.png',
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.05,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // Spacing below the logo
                // Login Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: screenWidth * 0.055,
                      fontFamily: 'Product Sans',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Spacing below the login text
                // Sign In with Google Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: SignInWithGoogleButton(
                    onPressed: () {
                      print('Google Sign-In button pressed');
                    },
                    isLoading: false,
                    isTwoLine: true,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Spacing below the Google button
                // Vertical Radios
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: VerticalRadios(
                    initialOption: "otp",
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Spacing below the radios
                // Email Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: CustomTextField(
                    controller: _emailController,
                    label: "Email",
                    onChanged: (value) {
                      _validateEmail(value); // Validate email on input change
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Spacing below the email field
                // OTP Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: CustomTextField(
                    controller: _otpController,
                    label: "OTP",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Spacing below the OTP field
                // Resend OTP Timer
                if (!canSendOTP)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Text(
                      "Resend OTP in ${countdown ~/ 60}:${(countdown % 60).toString().padLeft(2, '0')}",
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontFamily: 'Product Sans',
                        color: Colors.red,
                      ),
                    ),
                  ),
                SizedBox(height: screenHeight * 0.02), // Spacing below the timer
                // Generate OTP Button
                Center(
                  child: canSendOTP
                      ? RedButton(
                          label: "Generate OTP",
                          width: screenWidth * 0.85,
                          height: screenHeight * 0.06,
                          onPressed: () {
                            _startTimer();
                            print("OTP Generated for ${_emailController.text}");
                          },
                        )
                      : InactiveButton(
                          label: "Generate OTP",
                          width: screenWidth * 0.85,
                          height: screenHeight * 0.06,
                        ),
                ),
                SizedBox(height: screenHeight * 0.03), // Spacing below the button
                // Login Button
                Center(
                  child: RedButton(
                    label: "Login",
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.06,
                    onPressed: () async {
                      if (_otpController.text == correctOTP) {
                        print("Login successful");
                      } else {
                        await CustomPopup.show(
                          context: context,
                          title: 'Invalid OTP',
                          message: "The OTP you entered is incorrect. Please try again.",
                          buttonText: 'OK',
                          imagePath: 'public/assets/images/Alert.png',
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Spacing below the login button
                // Don't Have an Account Button
                Center(
                  child: ForgotPasswordButton(
                    label: "Don't have an account?",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}