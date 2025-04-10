import 'package:flutter/material.dart';
import 'package:semikart/Components/home/home_page.dart';
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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.3, // Push everything 30% down dynamically
              left: screenWidth * 0.04, // 4% of screen width for horizontal padding
              right: screenWidth * 0.04, // 4% of screen width for horizontal padding
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Semikart Logo
                Center(
                  child: Image.asset(
                    'public/assets/images/semikart_logo_medium.png',
                    width: screenWidth * 0.4, // Specify width
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // "Create Your Account" Text
                Center(
                  child: Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06, // Specify font size
                      fontFamily: 'Product Sans',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // SignInWithGoogleButton
                Center(
                  child: SignInWithGoogleButton(
                    onPressed: () {
                      print('Google Sign-In button pressed');
                    },
                    isLoading: false,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // Divider with "OR"
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                        endIndent: screenWidth * 0.02, // Specify spacing
                      ),
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Specify font size
                        fontFamily: 'Product Sans',
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                        indent: screenWidth * 0.02, // Specify spacing
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // CustomTextField for First Name
                CustomTextField(
                  controller: TextEditingController(),
                  label: "First Name",
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // CustomTextField for Last Name
                CustomTextField(
                  controller: TextEditingController(),
                  label: "Last Name",
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // CustomTextField for Email
                CustomTextField(
                  controller: TextEditingController(),
                  label: "Email",
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

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
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // CustomTextField for Company Name
                CustomTextField(
                  controller: TextEditingController(),
                  label: "Company Name",
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // Confirm Password Component
                ConfirmPasswordScreen(
                  onPasswordsMatch: (match) {
                    setState(() {
                      passwordsMatch = match; // Update the passwordsMatch state
                    });
                  },
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

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
                          fontSize: screenWidth * 0.035, // Specify font size
                          fontFamily: 'Product Sans',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // ForgotPasswordButton
                Center(
                  child: ForgotPasswordButton(
                    label: "Already have an account?", // Specify label
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPasswordScreen()), // Navigate to LoginScreen
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // Sign Up Button
                Center(
                  child: passwordsMatch && isTermsAccepted
                      ? RedButton(
                          label: "Sign Up", // Specify label
                          width: screenWidth * 0.9, // Specify width
                          height: screenHeight * 0.06, // Specify height
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage
                            );
                          },
                        )
                      : InactiveButton(
                          label: "Sign Up", // Specify label
                          width: screenWidth * 0.9, // Specify width
                          height: screenHeight * 0.06, // Specify height
                        ),
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing
              ],
            ),
          ),
        ),
      ),
    );
  }
}