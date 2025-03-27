import 'package:flutter/material.dart';

class SearchFailed extends StatelessWidget {
  const SearchFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 342, // Fixed width for the component
        height: 396, // Fixed height for the component
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Image.asset(
              'public/assets/images/search_failed.png', // Replace with your image path
              width: 150, // Adjust the width of the image
              height: 150, // Adjust the height of the image
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20), // Spacing between the image and text
            // Message
            const Text(
              "Sorry, we couldn't find any matching result for your Search.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20), // Spacing between the text and button
            // Button
            ElevatedButton(
              onPressed: () {
                // Add your button action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA51414), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              ),
              child: const Text(
                "Explore Categories",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}