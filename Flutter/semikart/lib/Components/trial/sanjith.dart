import 'package:flutter/material.dart';
import '../Commons/bottom_bar.dart'; // Import the bottom_bar_home.dart file
import '../Commons/header.dart'; // Import the header.dart file
import '../Commons/search_failed.dart'; // Import the search_failed.dart file
import '../Commons/red_button.dart'; // Import the RedButton component
import '../Commons/forgot_password.dart'; // Import the ForgotPasswordButton component
import '../rfq_bom/add_item_manually.dart'; // Import the DynamicTable component

class TestLayoutSanjith extends StatelessWidget {
  const TestLayoutSanjith({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(), // Use the updated Header as the AppBar
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final padding = screenWidth * 0.05; // Dynamic padding based on screen width

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SearchFailed Component
                  const SearchFailed(),
                  const SizedBox(height: 20), // Add spacing between components
                  // White Button Variant
                  RedButton(
                    label: "Go Back",
                    onPressed: () {
                      // Add your button action here
                      print("White button pressed");
                    },
                    isWhiteButton: true, // Trigger the white button variant
                    width: screenWidth * 0.5, // Button width is 50% of screen width
                  ),
                  const SizedBox(height: 20), // Add spacing between components
                  // Forgot Password Button
                  ForgotPasswordButton(
                    label: "Forgot Password", // Customizable text
                    onPressed: () {
                      // Add your navigation or action here
                      print("Forgot Password button pressed");
                    },
                  ),
                  const SizedBox(height: 20), // Add spacing between components
                  // Don't Have an Account Button
                  ForgotPasswordButton(
                    label: "Don't have an account", // Customizable text
                    onPressed: () {
                      // Add your navigation or action here
                      print("Don't have an account button pressed");
                    },
                  ),
                  const SizedBox(height: 20), // Add spacing between components
                  // DynamicTable Component
                  const DynamicTable(), // Let the table expand naturally
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(), // Bottom navigation bar
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TestLayoutSanjith(),
  ));
}
