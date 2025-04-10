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

    // Set the status bar style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

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
                  fontFamily: 'Product Sans', // Product Sans font
                  color: Colors.black, // Black color
                  fontWeight: FontWeight.bold, // Bold weight
                ),
              ),
            ),

            // Positioned SignInWithGoogleButton
            Positioned(
              left: screenWidth * 0.05, // 5% of screen width
              top: screenHeight * 0.25, // 25% of screen height
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
              left: screenWidth * 0.55, // 55% of screen width
              top: screenHeight * 0.22, // 22% of screen height
              child: VerticalRadios(
                initialOption: "password",
              ),
            ),

            // Positioned CustomTextField for Email
            Positioned(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05, // 5% padding on both sides
              top: screenHeight * 0.42, // 40% of screen height
              child: CustomTextField(
                controller: TextEditingController(), // Provide a controller
                label: "Email", // Set the label to "Email"
                height: screenHeight * 0.06, // 6% of screen height
              ),
            ),

            // Positioned PasswordTextField for Password
            Positioned(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05, // 5% padding on both sides
              top: screenHeight * 0.52, // 50% of screen height
              child: PasswordTextField(
                controller: TextEditingController(), // Provide a controller
                label: "Password", // Set the label to "Password"
                height: screenHeight * 0.06, // 6% of screen height
              ),
            ),

            // Positioned ForgotPasswordButton
            Positioned(
              right: screenWidth * 0.05, // 5% of screen width
              top: screenHeight * 0.62, // 60% of screen height
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
              top: screenHeight * 0.67, // 65% of screen height
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
              top: screenHeight * 0.77, // 75% of screen height
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