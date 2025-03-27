import 'package:flutter/material.dart';
import '../Commons/bottom_bar.dart'; // Import the bottom_bar_home.dart file
import '../Commons/header.dart'; // Import the header.dart file
import '../Commons/search_failed.dart'; // Import the search_failed.dart file
import '../Commons/red_button.dart'; // Import the RedButton component

class TestLayoutSanjith extends StatelessWidget {
  const TestLayoutSanjith({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(), // Use the updated Header as the AppBar
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            width: 200, // Optional: Set a custom width for the button
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(), // Bottom navigation bar
    );
  }
}
