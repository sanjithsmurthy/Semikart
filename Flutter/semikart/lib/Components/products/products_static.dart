import 'package:flutter/material.dart';
import '../common/search_bar.dart' as custom_search; // Import the SearchBar widget
import 'breadcrumbs.dart'; // Import the Breadcrumbs widget
import 'products_l2.dart';
import '../common/red_button.dart'; // Import the RedButton widget

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
              child: Text(
                'Electronic Components Categories Line Card',
                style: TextStyle(
                  color: const Color(0xFFA51414), // Red color (A51414)
                  fontSize: screenHeight *0.02, // Font size 25px
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.005), // Add spacing before the search bar

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: custom_search.SearchBar(), // Add the SearchBar widget here
            ),
            SizedBox(height: screenHeight * 0.015), // Add spacing before RFQ_CTA

            // RFQ Component (Using RedButton)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              // --- Proper RedButton Call ---
              child: RedButton(
                // isWhiteButton: true,
                label: 'Request for Quote', // Provide a meaningful label
                onPressed: () {
                  // Define the action when the button is pressed
                  // Example: Navigate to RFQ page or show a dialog
                  print('RFQ Button Pressed!');
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => RFQPage())); // Example navigation
                },
                // Optional parameters (can be omitted to use defaults):
                // isLoading: false, // Set to true to show loading indicator
                // width: screenWidth * 0.8, // Example custom width
                // height: 50, // Example custom height
                // fontSize: 16, // Example custom font size
                // isWhiteButton: false, // Set to true for the white variant
              ),
              // --- End of RedButton Call ---
            ),
            SizedBox(height: screenHeight * 0.001), // Further reduced spacing before breadcrumbs by 5px

            // Breadcrumbs (conditionally displayed)
            if (showBreadcrumbs)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Breadcrumbs(
                  items: [
                    BreadcrumbItem(
                      label: 'Products',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    BreadcrumbItem(
                      label: 'Circuit Protection',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProductsL2Page()),
                        );
                      },
                    ),
                    if (showL2ComponentBreadcrumb) // Conditionally show 'L2 Component 1'
                      BreadcrumbItem(
                        label: 'L2 Component 1',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProductsL2Page()),
                          );
                        },
                      ),
                  ],
                ), // Add the Breadcrumbs widget here
              ),
          ],
        ),
      ),
    );
  }
}

