import 'package:flutter/material.dart';
import '../../base_scaffold.dart'; // Import BaseScaffold for navigation
import '../common/signinwith_google.dart';
import 'custom_text_field.dart';
import 'confirm_password.dart'; // Import the ConfirmPasswordScreen component
import '../common/mobile_number_input.dart'; // Import the MobileNumberField component
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/inactive_red_button.dart'; // Import the InactiveButton widget
import 'login_password.dart'; // Import the LoginScreen component
import '../common/forgot_password.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passwordsMatch = false; // Track if passwords match
  bool isTermsAccepted = false; // Track if the checkbox is checked

  // Controllers for text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.08), // Space for the logo

                // Semikart Logo
                Image.asset(
                  'public/assets/images/semikart_logo_medium.png',
                  width: screenWidth * 0.4, // 40% of screen width
                  height: screenHeight * 0.05, // 5% of screen height
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // Display Name
                const Text(
                  'GFXAgency',
                  style: TextStyle(
                    fontSize: 20, // Set font size to 20
                    fontWeight: FontWeight.normal, // Remove bold styling
                     // Use Product Sans font
                    color: Colors.black, // Set text color to black
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // "Create Your Account" Text
                Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06, // 6% of screen width
                     // Use Product Sans font
                    color: Colors.black, // Black text color
                    fontWeight: FontWeight.bold, // Bold font weight
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // Google Sign-In Button
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
                Center(
                  child: CustomTextField(
                    width: screenWidth * 0.75, // Specify width
                    height: screenHeight * 0.06, // Specify height
                    controller: firstNameController,
                    label: "First Name",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // CustomTextField for Last Name
                Center(
                  child: CustomTextField(
                    width: screenWidth * 0.75, // Specify width
                    height: screenHeight * 0.06, // Specify height
                    controller: lastNameController,
                    label: "Last Name",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // CustomTextField for Email
                Center(
                  child: CustomTextField(
                    width: screenWidth * 0.75, // Specify width
                    height: screenHeight * 0.06, // Specify height
                    controller: emailController,
                    label: "Email",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // MobileNumberField
                Center(
                  child: MobileNumberField(
                    width: screenWidth * 0.75, // Specify width
                    height: screenHeight * 0.06, // Specify height
                    controller: mobileNumberController,
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
                ),
                SizedBox(height: screenHeight * 0.025), // Add spacing

                // CustomTextField for Company Name
                Center(
                  child: CustomTextField(
                    width: screenWidth * 0.75, // Specify width
                    height: screenHeight * 0.06, // Specify height
                    controller: companyNameController,
                    label: "Company Name",
                  ),
                ),
                SizedBox(height: screenHeight * 0.015), // Add spacing

                // Confirm Password Component
                ConfirmPasswordScreen(
                  width: screenWidth, // Specify width
                  height: screenHeight * 0.06, // Specify height
                  onPasswordsMatch: (match) {
                    setState(() {
                      passwordsMatch = match; // Update the passwordsMatch state
                    });
                  },
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // ForgotPasswordButton
                Align(
                  alignment: Alignment.centerRight, // Align to the right
                  child: ForgotPasswordButton(
                    label: "Already have an account?", // Specify label
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPasswordNewScreen()), // Navigate to LoginScreen
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // Checkbox for Terms and Conditions
                Align(
                  alignment: Alignment.centerRight, // Align the entire row to the right
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Minimize the row's width
                    children: [
                      Checkbox(
                        value: isTermsAccepted,
                        onChanged: (value) {
                          setState(() {
                            isTermsAccepted = value ?? false; // Update the checkbox state
                          });
                        },
                        activeColor: Color(0xFFA51414), // Set checkbox color
                      ),
                      Text(
                        "I agree to the terms and conditions",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035, // Specify font size
                          
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right, // Align text to the right
                      ),
                    ],
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
                              MaterialPageRoute(builder: (context) => BaseScaffold()), // Navigate to HomePage
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