import 'dart:async';
import 'package:flutter/material.dart';
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import 'horizontal_radios.dart'; // Import the HorizontalRadios widget
import 'custom_text_field.dart'; // Import the CustomTextField widget
import '../common/forgot_password.dart';
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/inactive_red_button.dart'; // Import the InactiveButton widget
import 'login_password.dart'; // Import the LoginPassword screen
import 'signup_screen.dart'; // Import the SignUpScreen
import '../common/popup.dart'; // Import the CustomPopup widget
import 'package:Semikart/services/google_auth_service.dart';

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
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // resizeToAvoidBottomInset: true, // Default is true
      body: SafeArea(
        // Wrap the Stack with SingleChildScrollView
        child: SingleChildScrollView(
          child: SizedBox( // Use SizedBox to constrain the Stack's height
            height: screenHeight, // Ensure Stack takes at least the screen height initially
            width: screenWidth,
            child: Stack(
              children: [
                // White background (Consider setting Scaffold background)
                // Container(
                //   width: screenWidth,
                //   height: screenHeight,
                //   color: Colors.white, // Set the background color to white
                // ),

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

                // Centered SignInWithGoogleButton (Positioned like login_password_new.dart)
                Positioned(
                  left: screenWidth * 0.05, // 5% of screen width
                  right: screenWidth * 0.05, // 5% padding on both sides
                  top: screenHeight * 0.23, // 23% of screen height (Adjusted to match)
                  child: Center(
                    child: SignInWithGoogleButton(
                      onPressed: () async {
                        final googleAuthService = GoogleAuthService();
                        final user = await googleAuthService.signInWithGoogle();

                        if (user != null) {
                          print("Google Sign-In successful: ${user.email}");
                          // Navigate to the home page or handle successful login
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Google Sign-In failed.')),
                          );
                        }
                      },
                      isLoading: false, // Set to true if loading state is required
                    ),
                  ),
                ),

                // HorizontalRadios below Google Sign-In button (Positioned like login_password_new.dart)
                Positioned(
                  left: screenWidth * 0.05, // 5% of screen width
                  right: screenWidth * 0.05, // 5% padding on both sides
                  top: screenHeight * 0.33, // 33% of screen height (Adjusted to match)
                  child: Center(
                    child: HorizontalRadios(
                      initialOption: "otp", // Set the initial selected option to OTP
                    ),
                  ),
                ),

                // Positioned CustomTextField for Email
                Positioned(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05, // 5% padding on both sides
                  top: screenHeight * 0.45, // 45% of screen height
                  child: CustomTextField(
                    controller: _emailController,
                    label: "Email",
                    onChanged: (value) {
                      _validateEmail(value); // Validate email on input change
                    },
                  ),
                ),

                // OTP Section
                Positioned(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05, // Align with other components
                  top: screenHeight * 0.55, // Adjust position to align with layout
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.01), // Space between "Send OTP" and the text field

                      // OTP Input Field
                      CustomTextField(
                        controller: _otpController, // Controller for OTP input
                        label: "OTP", // Set the label to "OTP"
                      ),
                    ],
                  ),
                ),

                // Resend OTP Timer Positioned at top: screenHeight * 0.65
                Positioned(
                   // Align with other components
                  right: screenWidth * 0.09, // Align with other components
                  top: screenHeight * 0.65, // Position at 65% of screen height
                  child: canSendOTP
                      ? SizedBox.shrink() // Hide the timer if OTP can be sent
                      : Text(
                          "Resend OTP in ${countdown ~/ 60}:${(countdown % 60).toString().padLeft(2, '0')}",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035, // Scaled font size

                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center, // Center the text
                        ),
                ),

                // Positioned Generate OTP Button
                Positioned(
                  top: screenHeight * 0.78, // Position just above the Login button
                  left: 0, // Ensure the button spans the full width
                  right: 0, // Ensure the button spans the full width
                  child: Center(
                    child: canSendOTP
                        ? RedButton(
                            label: "Generate OTP", // Button label
                            width: screenWidth * 0.85, // 85% of screen width
                            height: screenHeight * 0.06, // Match the height of the Login button
                            onPressed: () {
                              _startTimer(); // Start the timer when OTP is generated
                              print("OTP Generated for ${_emailController.text}");
                            },
                          )
                        : InactiveButton(
                            label: "Generate OTP", // Button label
                            width: screenWidth * 0.85, // 85% of screen width
                            height: screenHeight * 0.06, // Match the height of the Login button
                          ),
                  ),
                ),

                // Positioned "Don't have an account?" Button
                Positioned(
                  right: screenWidth * 0.05, // 5% of screen width
                  top: screenHeight * 0.70, // Push upwards
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
                  top: screenHeight * 0.884, // 88.2% of screen height
                  left: 0, // Ensure the button spans the full width
                  right: 0, // Ensure the button spans the full width
                  child: Center(
                    child: RedButton(
                      label: "Login", // Set the label to "Login"
                      width: screenWidth * 0.85, // 85% of screen width
                      height: screenHeight * 0.06, // 6% of screen height
                      onPressed: () async {
                        // Check if the entered OTP matches the correct OTP
                        if (_otpController.text == correctOTP) {
                          print("Login successful");
                        } else {
                          // Show popup using CustomPopup
                          await CustomPopup.show(
                            context: context,
                            title: 'Invalid OTP',
                            message: "The OTP you entered is incorrect. Please try again.",
                            buttonText: 'OK',
                            imagePath: 'public/assets/images/Alert.png', // Optional image path
                          );
                        }
                      },
                    ),
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