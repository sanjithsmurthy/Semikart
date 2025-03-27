import 'package:flutter/material.dart';
import '../Commons/bottom_bar.dart'; // Import the bottom_bar_home.dart file
import '../Commons/header.dart'; // Import the header.dart file
import '../Commons/search_failed.dart'; // Import the search_failed.dart file
import '../Commons/red_button.dart'; // Import the RedButton component
import '../rfq_bom/add_item_manually.dart'; // Import the DynamicTable component

class TestLayoutSanjith extends StatelessWidget {
  const TestLayoutSanjith({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(), // Use the updated Header as the AppBar
      body: SingleChildScrollView(
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
              width: 200, // Optional: Set a custom width for the button
            ),
            const SizedBox(height: 20), // Add spacing between components
            // DynamicTable Component
            SizedBox(
              height: 400, // Set a fixed height for the table
              child: const DynamicTable(),
            ),
          ],
        ),
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
