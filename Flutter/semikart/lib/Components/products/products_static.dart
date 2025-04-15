`import 'package:flutter/material.dart';
import '../common/search_builtin.dart' as custom_search; // Import the SearchBar widget
import '../common/RFQ_CTA.dart'; // Import the RFQ_CTA widget

class ProductsHeaderContent extends StatelessWidget {
  const ProductsHeaderContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Material( // Wrap the content in a Material widget
      color: Colors.white, // Set the background color to white
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Heading
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: const Text(
                'Electronic Components Categories Line Card',
                style: TextStyle(
                  color: Color(0xFFA51414), // Red color (A51414)
                  fontSize: 25, // Font size 25px
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16), // Add spacing before the search bar

            // Search Bar
            Center(
              child: custom_search.SearchBar(), // Add the SearchBar widget here
            ),
            const SizedBox(height: 16), // Add spacing before RFQ_CTA

            // RFQ Component
            Center(
              child: const RFQComponent(), // Add the RFQ_CTA widget here
            ),
          ],
        ),
      ),
    );
  }
}

