import 'package:flutter/material.dart';

class LoginPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 512, // Set the width to 512
          height: 917, // Set the height to 917
          color: Colors.white, // Set the background color to white
          child: Center(
            child: Text(
              'Login Password Screen',
              style: TextStyle(
                fontSize: 18,
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