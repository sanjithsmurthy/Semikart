import 'package:flutter/material.dart';
import '../common/search_bar.dart' as custom_search; // Import the SearchBar widget
import '../common/red_button.dart'; // Import the RedButton widget

class ProductsHeaderContent extends StatelessWidget {
  const ProductsHeaderContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.white, // Set the background color to white
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Heading
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Text(
                'Electronic Components Categories Line Card',
                style: TextStyle(
                  color: Color(0xFFA51414), // Red color (A51414)
                  fontSize: screenHeight * 0.025, // Font size 25px
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Add spacing before the search bar

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: custom_search.SearchBar(), // Add the SearchBar widget here
            ),
            SizedBox(height: screenHeight * 0.02), // Add spacing before RFQ_CTA

            // Red Button
            Center(
              child: RedButton(
                label: 'Request for Quote (RFQ)',
                onPressed: () {
                  // Add your RFQ button logic here
                  print('RFQ button pressed!');
                },
                width: screenWidth * 0.5, // Adjust width as needed
                height: screenHeight * 0.05, // Adjust height as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}

