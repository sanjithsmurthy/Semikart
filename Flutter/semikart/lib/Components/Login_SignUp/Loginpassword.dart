import 'package:flutter/material.dart';
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import 'vertical_radios.dart'; // Import the VerticalRadios widget
import 'custom_text_field.dart'; // Import the CustomTextField widget
import '../common/password_text_field.dart'; // Import the PasswordTextField widget
import '../common/forgot_password.dart'; // Import the ForgotPasswordButton widget
import '../common/red_button.dart'; // Import the RedButton widget

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
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // White background
          Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.white, // Set the background color to white
          ),

          // Positioned Semikart logo
          Positioned(
            left: screenWidth * 0.09, // 9% of screen width
            top: screenHeight * 0.14, // 14% of screen height
            child: Image.asset(
              'public/assets/images/Semikart_Logo_Medium.png', // Path to the logo
              width: screenWidth * 0.5, // 50% of screen width
              height: screenHeight * 0.04, // 4% of screen height
              fit: BoxFit.contain, // Ensure the image fits within the dimensions
            ),
          ),

          // Positioned Login text
          Positioned(
            left: screenWidth * 0.09, // 9% of screen width
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
            left: screenWidth * 0.07, // 7% of screen width
            top: screenHeight * 0.33, // 33% of screen height
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
            left: screenWidth * 0.65, // 65% of screen width
            top: screenHeight * 0.33, // 33% of screen height
            child: VerticalRadios(), // Display the VerticalRadios widget
          ),

          // First horizontal black line
          Positioned(
            left: screenWidth * 0.09, // 9% of screen width
            top: screenHeight * 0.46, // 46% of screen height
            child: Container(
              width: screenWidth * 0.4, // 40% of screen width
              height: 1, // Fixed height
              color: Colors.black, // Line color
            ),
          ),

         

          // Positioned "OR" text exactly in the middle
          Positioned(
            left: screenWidth * 0.50, // Centered between the two lines
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
            left: screenWidth * 0.57, // 51% of screen width
            top: screenHeight * 0.46, // 46% of screen height
            child: Container(
              width: screenWidth * 0.4, // 40% of screen width
              height: 1, // Fixed height
              color: Colors.black, // Line color
            ),
          ),

          // Positioned CustomTextField for Email
          Positioned(
            left: screenWidth * 0.06, // 6% of screen width
            top: screenHeight * 0.52, // 52% of screen height
            child: CustomTextField(
              controller: TextEditingController(), // Provide a controller
              label: "Email", // Set the label to "Email"
            ),
          ),

          // Positioned PasswordTextField for Password
          Positioned(
            left: screenWidth * 0.06, // 6% of screen width
            top: screenHeight * 0.65, // 65% of screen height
            child: PasswordTextField(
              controller: TextEditingController(), // Provide a controller
              label: "Password", // Set the label to "Password"
            ),
          ),

          // Positioned ForgotPasswordButton
          Positioned(
            left: screenWidth * 0.6, // 70% - 10% of screen width
            top: screenHeight * 0.78, // 78% of screen height
            child: ForgotPasswordButton(
              label: "Forgot Password", // Set the label
              onPressed: () {
                // Handle the Forgot Password button click
                print('Forgot Password button clicked');
              },
            ),
          ),

          // Positioned "Don't have an account?" Button
          Positioned(
            left: screenWidth * 0.48, // 58% - 10% of screen width
            top: screenHeight * 0.82, // 82% of screen height
            child: ForgotPasswordButton(
              label: "Don't have an account?", // Set the label
              onPressed: () {
                // Handle the button click
                print('Don\'t have an account button clicked');
              },
            ),
          ),

          // Positioned RedButton for Login
          Positioned(
            left: screenWidth * 0.09, // 9% of screen width
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
    );
  }
}