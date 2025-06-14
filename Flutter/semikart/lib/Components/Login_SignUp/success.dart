import 'package:Semikart/Components/Login_SignUp/login_password.dart'; // Import LoginPasswordNewScreen
import 'package:flutter/material.dart';
import '../common/red_button.dart'; // Restore RedButton import
import 'package:Semikart/base_scaffold.dart'; // <-- Import BaseScaffold

// Revert to StatelessWidget
class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 234), // Space from the top of the screen

            // Success Image
            Image.asset(
              'public/assets/images/checksucccess.png', // Path to the image
              width: 164, // Width of the image
              height: 164,
              fit: BoxFit.contain, // Height of the image
            ),

            SizedBox(height: 15), // Space below the image

            // "Success!" Text
            Text(
              "Success!",
              style: TextStyle(
                fontSize: 22, // Font size
                fontWeight: FontWeight.normal, // Regular weight
                 // Product Sans font
                color: Colors.black, // Black color
              ),
            ),

            SizedBox(height: 50), // Space below "Success!" text

            // "Congratulations!" Text - Reverted
            Text(
              "Successfully signed up, now login", // Keep updated text
              textAlign: TextAlign.center, // Center align the text
              style: TextStyle(
                fontSize: 18, // Font size
                fontWeight: FontWeight.normal, // Regular weight
                 // Product Sans font
                color: Color(0xFFB6B6B6), // Grey color
              ),
            ),

            SizedBox(height: 50), // Space below the description text

            // Restore Red Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // 5% padding on both sides
              child: RedButton(
                label: "Continue to App", // Updated label
                width: double.infinity, // Stretch the button horizontally
                height: 48, // Button height
                onPressed: () {
                  // Navigate to BaseScaffold
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const BaseScaffold()), // Navigate to BaseScaffold
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}