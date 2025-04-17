import 'package:flutter/material.dart';
import '../common/search_bar.dart' as custom_search; // Import the SearchBar widget
import 'products_l2.dart'; // Import the ProductsL2Page widget

class ProductsHeaderContent extends StatelessWidget {
  final bool showBreadcrumbs; // Parameter to control breadcrumbs visibility
  final bool showL2ComponentBreadcrumb; // Parameter to control 'L2 Component 1' breadcrumb visibility

  const ProductsHeaderContent({
    super.key,
    this.showBreadcrumbs = true, // Default is true
    this.showL2ComponentBreadcrumb = false, // Default is false
  });

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
            SizedBox(height: screenHeight * 0.02), // Add spacing before the search bar

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: custom_search.SearchBar(), // Add the SearchBar widget here
            ),

          ],
        ),
      ),
    );
  }
}

