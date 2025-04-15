import 'package:flutter/material.dart';
import '../common/search_builtin.dart' as custom_search; // Import the SearchBar widget
import '../common/RFQ_CTA.dart'; // Import the RFQ_CTA widget
import '../common/breadcrumbs.dart'; // Import the Breadcrumbs widget

class ProductsHeaderContent extends StatelessWidget {
  final bool showBreadcrumbs; // Parameter to control breadcrumbs visibility

  const ProductsHeaderContent({super.key, this.showBreadcrumbs = true}); // Default is true

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
            const SizedBox(height: 16), // Add spacing before breadcrumbs

            // Breadcrumbs (conditionally displayed)
            if (showBreadcrumbs)
              Center(
                child: Breadcrumbs(
                  items: [
                    BreadcrumbItem(label: 'Products', onTap: () => Navigator.of(context).pop()),
                    BreadcrumbItem(label: 'L1 components', onTap: () {}),
                  ],
                ), // Add the Breadcrumbs widget here
              ),
          ],
        ),
      ),
    );
  }
}

