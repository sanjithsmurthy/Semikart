import 'package:flutter/material.dart';
import '../Commons/header_withback.dart'; // Import the HeaderWithBack component
import '../Commons/bottom_bar.dart'; // Import the BottomNavBar component

class RFQFullPage extends StatelessWidget {
  const RFQFullPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color of the screen to white
      backgroundColor: Colors.white,

      // AppBar implemented using HeaderWithBack
      appBar: CombinedAppBar(
        title: "RFQ Full Page", // Title for the app bar
        onBackPressed: () {
          Navigator.pop(context); // Navigate back to the previous page
        },
      ),

      // Main body content
      body: Center(
        child: Container(
          width: 412, // Fixed width
          constraints: const BoxConstraints(
            minHeight: 100, // Minimum height (adjustable as content grows)
          ),
          padding:
              const EdgeInsets.all(16.0), // Add padding inside the component
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Example content
              Text(
                "This is the RFQ Full Page",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "The height of this page adjusts dynamically based on its content.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),

      // BottomNavBar implemented as the bottom bar
      bottomNavigationBar:
          const BottomNavBar(), // BottomNavBar from bottom_bar.dart
    );
  }
}
