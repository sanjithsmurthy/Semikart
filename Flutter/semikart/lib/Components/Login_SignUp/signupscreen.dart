import 'package:flutter/material.dart';
import '../common/signinwith_google.dart';
import 'custom_text_field.dart';
import 'password_text_field.dart';
import '../common/mobile_number_input.dart'; // Import the MobileNumberField component

class SignUpScreen extends StatelessWidget {
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
              SizedBox(height: 16),

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
              SizedBox(height: 16),

              // PasswordTextField for Password
              PasswordTextField(
                controller: TextEditingController(),
                label: "Password",
              ),
              SizedBox(height: 24),

              // Submit Button (Optional)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print('Sign Up button pressed');
                  },
                  child: Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}