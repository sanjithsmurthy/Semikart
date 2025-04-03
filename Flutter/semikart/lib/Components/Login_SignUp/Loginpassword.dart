import 'package:flutter/material.dart';
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import '../common/vertical_radios.dart'; // Import the VerticalRadios widget
import '../Login_SignUp/Loginpassword.dart'; // Import the LoginPasswordScreen

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
    // Get the screen size using MediaQuery
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
            left: 36, // 36 from the left
            top: 113, // 113 from the top
            child: Image.asset(
              'public/assets/images/Semikart_Logo_Medium.png', // Path to the logo
              width: 190, // Set the width to 190
              height: 28, // Set the height to 28
              fit: BoxFit.contain, // Ensure the image fits within the dimensions
            ),
          ),

          // Positioned Login text
          Positioned(
            left: 36, // 36 from the left
            top: 197, // 197 from the top
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 25, // Font size 25
                fontFamily: 'Product Sans', // Product Sans font
                color: Colors.black, // Black color
                fontWeight: FontWeight.normal, // Regular weight
              ),
            ),
          ),

          // Positioned SignInWithGoogleButton
          Positioned(
            left: 28, // 28 from the left
            top: 263, // 263 from the top
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
            left: 250, // 150 from the left
            top: 252, // 252 from the top
            child: VerticalRadios(), // Display the VerticalRadios widget
          ),

          // Positioned "OR" text
          Positioned(
            left: 194.5, // 194.5 from the left
            top: 361, // 361 from the top
            child: Text(
              'OR',
              style: TextStyle(
                fontSize: 16, // Font size 16
                fontFamily: 'Product Sans', // Product Sans font
                color: Colors.black, // Black color
                fontWeight: FontWeight.normal, // Regular weight
              ),
            ),
          ),

          // First horizontal black line
          Positioned(
            left: 33.5, // 33.5 from the left
            top: 370, // 370 from the top
            child: Container(
              width: 151, // Width of the line
              height: 1, // Height of the line
              color: Colors.black, // Line color
            ),
          ),

          // Second horizontal black line
          Positioned(
            left: 227.5, // 227.5 from the left
            top: 370, // 370 from the top
            child: Container(
              width: 151, // Width of the line
              height: 1, // Height of the line
              color: Colors.black, // Line color
            ),
          ),
        ],
      ),
    );
  }
}