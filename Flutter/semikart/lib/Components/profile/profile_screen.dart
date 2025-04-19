import 'package:flutter/material.dart';
import 'dart:io'; // Still needed by the dummy callback type
import 'profilepic.dart'; // Import the custom ProfilePicture widget
import '../common/red_button.dart'; // Import the RedButton widget

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Dummy callback function - does nothing in this simplified version
  void _doNothing(File image) {
    // This function is required by ProfilePicture, but we don't
    // handle the image selection in this screen anymore.
    print("Image selected (but not handled in ProfileScreen): ${image.path}");
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Define padding dynamically
    final horizontalPadding = screenWidth * 0.05;
    final buttonSpacing = screenWidth * 0.04; // Dynamic spacing between buttons

    return Scaffold(
      // appBar: AppBar(title: const Text('Profile')), // Optional AppBar
      body: Padding( // Add padding around the entire Column
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: [
            // Profile Picture Section using the custom widget
            Padding(
              // No horizontal padding needed here as it's handled by the outer Padding
              padding: const EdgeInsets.only(top: 0), // Ensure zero top padding
              child: Center( // Horizontally center the ProfilePicture widget
                child: ProfilePicture(
                  // imageUrl: 'YOUR_INITIAL_IMAGE_URL_HERE', // Optional: Provide an initial image URL
                  onImageSelected: _doNothing, // Pass the dummy callback
                ),
              ),
            ),

            const SizedBox(height: 24), // Add spacing below the profile picture

            // Row for the two buttons using Expanded for flexible scaling
            Row(
              children: [
                Expanded( // Make Button 1 flexible
                  child: RedButton(
                    label: 'Change Password',
                    // isWhiteButton: true,
                    fontWeight: FontWeight.bold,
                    height: screenWidth * 0.12,
                    width: screenWidth * 0.3, // Adjust height as needed
                    onPressed: () {
                      print('Button 1 pressed');
                      // Add functionality for Button 1
                    },
                    // Remove fixed width, Expanded handles it
                    // height: 40, // Optional: Keep fixed height or make dynamic
                  ),
                ),
                SizedBox(width: buttonSpacing), // Dynamic spacing between buttons
                Expanded( // Make Button 2 flexible
                  child: RedButton(
                    label: 'Logout',
                    fontWeight: FontWeight.bold,
                    width: screenWidth * 0.3,
                    height: screenWidth * 0.12, // Adjust height as needed
                    onPressed: () {
                      print('Button 2 pressed');
                      // Add functionality for Button 2
                    },
                    // Remove fixed width, Expanded handles it
                    // height: 40, // Optional: Keep fixed height or make dynamic
                  ),
                ),
              ],
            ),

            // Add other widgets below if needed
            // const SizedBox(height: 20),
            // const Text('Other Content...'),
          ],
        ),
      ),
    );
  }
}