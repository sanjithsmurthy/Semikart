import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16.0, // Left padding
            screenHeight * 0.12, // Top padding (113px as a percentage of screen height)
            16.0, // Right padding
            16.0, // Bottom padding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
            children: [
              // Semikart Logo
              Padding(
                padding: const EdgeInsets.only(left: 8.0), // Shift logo to the left
                child: Image.asset(
                  'public/assets/images/Semikart_Logo_Medium.png',
                  width: screenWidth * 0.4, // 40% of screen width
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 24),

              // "Create Your Account" Text
              Padding(
                padding: const EdgeInsets.only(left: 8.0), // Shift text to the left
                child: Text(
                  'Create your account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06, // 6% of screen width
                    fontFamily: 'Product Sans',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 24),

              // SignInWithGoogleButton
              Center(
                child: SignInWithGoogleButton(
                  onPressed: () {
                    print('Google Sign-In button pressed');
                  },
                  isLoading: false,
                ),
              ),
              SizedBox(height: 24),

              // First horizontal black line
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                      endIndent: 8,
                    ),
                  ),
                  Text(
                    'OR',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Product Sans',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                      indent: 8,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // CustomTextField for First Name
              CustomTextField(
                controller: TextEditingController(),
                label: "First Name",
              ),
              SizedBox(height: 16),

              // CustomTextField for Last Name
              CustomTextField(
                controller: TextEditingController(),
                label: "Last Name",
              ),
              SizedBox(height: 16),

              // CustomTextField for Email
              CustomTextField(
                controller: TextEditingController(),
                label: "Email",
              ),
              SizedBox(height: 12),

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
              SizedBox(height: 16),

              // CustomTextField for Company Name
              CustomTextField(
                controller: TextEditingController(),
                label: "Company Name",
              ),
              SizedBox(height: 2), // Reduced spacing above ConfirmPasswordScreen

              // Confirm Password Component
              ConfirmPasswordScreen(
                onPasswordsMatch: (match) {
                  setState(() {
                    passwordsMatch = match; // Update the passwordsMatch state
                  });
                },
              ),
              SizedBox(height: 16), // Reduced spacing below ConfirmPasswordScreen

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
                        fontSize: 14,
                        fontFamily: 'Product Sans',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

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

              SizedBox(height: 16), // Add spacing below the "Already have an account?" text

              // Button
              Center(
                child: passwordsMatch && isTermsAccepted
                    ? RedButton(
                        label: "Sign Up", // Button label
                        width: screenWidth * 0.9, // Dynamically scale width
                        height: screenHeight * 0.06, // Dynamically scale height
                        onPressed: () {
                          // Handle sign-up action
                          print("Passwords match and terms accepted! Proceeding with sign-up...");
                        },
                      )
                    : InactiveButton(
                        label: "Sign Up", // Button label
                        width: screenWidth * 0.9, // Dynamically scale width
                        height: screenHeight * 0.06, // Dynamically scale height
                      ),
              ),
              SizedBox(height: 16), // Add spacing below the button
            ],
          ),
        ),
      ),
    );
  }
}