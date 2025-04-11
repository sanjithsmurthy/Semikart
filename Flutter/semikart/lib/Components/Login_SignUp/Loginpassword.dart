import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this package
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import 'vertical_radios.dart'; // Import the VerticalRadios widget
import 'custom_text_field.dart'; // Import the CustomTextField widget
import 'password_text_field.dart'; // Import the PasswordTextField widget
import '../common/forgot_password.dart'; // Import the ForgotPasswordButton widget
import '../common/red_button.dart'; // Import the RedButton widget
import 'signupscreen.dart'; // Import the SignUpScreen widget
import 'forgot_password.dart'; // Import the ForgotPassword screen

class TestLayoutSanjana extends StatefulWidget {
  const TestLayoutSanjana({super.key});

  @override
  State<TestLayoutSanjana> createState() => _TestLayoutSanjanaState();
}

class _TestLayoutSanjanaState extends State<TestLayoutSanjana> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Component Testing',
          style: TextStyle(fontFamily: 'Product Sans'),
        ),
        backgroundColor: Color(0xFFA51414),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Other components...

              SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  // Navigate to the LoginPasswordScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  'LoginPassword Page',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Product Sans',
                    color: Colors.blue, // Blue color to indicate it's clickable
                    decoration: TextDecoration.underline, // Underline for clickable text
                  ),
                ),
              ),
              SizedBox(height: 32), // Add spacing after the text

              VerticalRadios(
                initialOption: "password"
              ),

              // Other components...
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensures the layout adjusts when the keyboard appears
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
                    initialOption: "password",
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Spacing below the radios
                // Email Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: CustomTextField(
                    controller: TextEditingController(),
                    width: screenWidth,
                    label: "Email",
                    height: screenHeight * 0.06,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Spacing below the email field
                // Password Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: PasswordTextField(
                    controller: TextEditingController(),
                    width: screenWidth,
                    label: "Password",
                    height: screenHeight * 0.06,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Spacing below the password field
                // Forgot Password Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: ForgotPasswordButton(
                    label: "Forgot Password?",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Spacing below the forgot password button
                // Don't Have an Account Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                SizedBox(height: screenHeight * 0.03), // Spacing below the account button
                // Login Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: RedButton(
                    label: "Login",
                    width: screenWidth * 0.90,
                    height: screenHeight * 0.06,
                    onPressed: () {
                      print('Login button clicked');
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