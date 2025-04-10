import 'package:flutter/material.dart';
import 'package:semikart/Components/home/home_page.dart';
import 'package:flutter/services.dart'; // Import for SystemUiOverlayStyle
import '../common/signinwith_google.dart';
import 'custom_text_field.dart';
import 'confirm_password.dart'; // Import the ConfirmPasswordScreen component
import '../common/mobile_number_input.dart'; // Import the MobileNumberField component
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/inactive_red_button.dart'; // Import the InactiveButton widget
import 'loginpassword.dart'; // Import the LoginScreen component
import '../common/forgot_password.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passwordsMatch = false; // Track if passwords match
  bool isTermsAccepted = false; // Track if the checkbox is checked

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Set the status bar style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set the status bar background color to white
      statusBarIconBrightness: Brightness.dark, // Set the status bar icons to dark
    ));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, // 4% of screen width for horizontal padding
              vertical: screenHeight * 0.02, // 2% of screen height for vertical padding
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Semikart Logo
                Center(
                  child: Image.asset(
                    'public/assets/images/semikart_logo_medium.png',
                    width: screenWidth * 0.4, // 40% of screen width
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // 3% of screen height

                // "Create Your Account" Text
                Center(
                  child: Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06, // 6% of screen width
                      fontFamily: 'Product Sans',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // 3% of screen height

                // SignInWithGoogleButton
                Center(
                  child: SignInWithGoogleButton(
                    onPressed: () {
                      print('Google Sign-In button pressed');
                    },
                    isLoading: false,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // 3% of screen height

                // First horizontal black line
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                        endIndent: screenWidth * 0.02, // 2% of screen width
                      ),
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // 4% of screen width
                        fontFamily: 'Product Sans',
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                        indent: screenWidth * 0.02, // 2% of screen width
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03), // 3% of screen height

                // CustomTextField for First Name
                CustomTextField(
                  controller: TextEditingController(),
                  label: "First Name",
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height

                // CustomTextField for Last Name
                CustomTextField(
                  controller: TextEditingController(),
                  label: "Last Name",
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height

                // CustomTextField for Email
                CustomTextField(
                  controller: TextEditingController(),
                  label: "Email",
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height

                // MobileNumberField
                MobileNumberField(
                  controller: TextEditingController(),
                  label: 'Mobile Number',
                  countryCodes: ['+91', '+1', '+44'],
                  defaultCountryCode: '+91',
                  onCountryCodeChanged: (code) {
                    print('Selected country code: $code');
                  },
                  onValidationFailed: (number) {
                    print('Invalid mobile number: $number');
                  },
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height

                // CustomTextField for Company Name
                CustomTextField(
                  controller: TextEditingController(),
                  label: "Company Name",
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height

                // Confirm Password Component
                ConfirmPasswordScreen(
                  onPasswordsMatch: (match) {
                    setState(() {
                      passwordsMatch = match; // Update the passwordsMatch state
                    });
                  },
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height

                // Checkbox for Terms and Conditions
                Row(
                  children: [
                    Checkbox(
                      value: isTermsAccepted,
                      onChanged: (value) {
                        setState(() {
                          isTermsAccepted = value ?? false; // Update the checkbox state
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "I agree to the terms and conditions",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035, // 3.5% of screen width
                          fontFamily: 'Product Sans',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height

                // ForgotPasswordButton
                Center(
                  child: ForgotPasswordButton(
                    label: "Already have an account?", // Set the label
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPasswordScreen()), // Navigate to LoginScreen
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height

                // Sign Up Button
                Center(
                  child: passwordsMatch && isTermsAccepted
                      ? RedButton(
                          label: "Sign Up", // Button label
                          width: screenWidth * 0.9, // 90% of screen width
                          height: screenHeight * 0.06, // 6% of screen height
                          onPressed: () {
                            // Handle sign-up action
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()), // Replace with your HomePage widget
                            );
                          },
                        )
                      : InactiveButton(
                          label: "Sign Up", // Button label
                          width: screenWidth * 0.9, // 90% of screen width
                          height: screenHeight * 0.06, // 6% of screen height
                        ),
                ),
                SizedBox(height: screenHeight * 0.03), // 3% of screen height
              ],
            ),
          ),
        ),
      ),
    );
  }
}