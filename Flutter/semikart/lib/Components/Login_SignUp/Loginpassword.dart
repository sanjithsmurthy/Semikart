import 'package:flutter/material.dart';

class LoginPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          width: screenWidth * 0.8, // Set the width to 80% of the screen width
          height: screenHeight * 0.9, // Set the height to 90% of the screen height
          color: Colors.white, // Set the background color to white
          child: Center(
            child: Text(
              'Login Password Screen',
              style: TextStyle(
                fontSize: screenWidth * 0.04, // Font size scales with screen width
                fontFamily: 'Product Sans',
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}