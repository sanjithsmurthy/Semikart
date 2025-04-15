import 'package:flutter/material.dart';
import '../common/header.dart'; // Import the Header widget
import '../products/products_static.dart'; // Import the ProductsHeaderContent widget
import '../products/l2_page_redbox.dart'; // Import the L2PageRedBox widget
import '../products/products_l1.dart'; // Import the ProductsL1Page widget

class ProductsL3Page extends StatelessWidget {
  const ProductsL3Page({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Header(
        showBackButton: true, // Show the back button
        title: 'Products', // Set the title
        onBackPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductsL1Page()),
          ); // Navigate back to the previous page
        },
        onLogoTap: () {
          Navigator.pushNamed(context, '/home'); // Navigate to the home page
        },
      ),
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.4), // Leave space for the fixed header
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)

                  // Step 2: Implement l2_page_redbox.dart
                  const RedBorderBox(text: 'L3 Component 1'),
                  SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                  const RedBorderBox(text: 'L3 Component 2'),
                  SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                  const RedBorderBox(text: 'L3 Component 3'),
                  SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                  const RedBorderBox(text: 'L3 Component 4'),
                  SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                  const RedBorderBox(text: 'L3 Component 5'),
                  SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                  const RedBorderBox(text: 'L3 Component 6'),
                  SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                  const RedBorderBox(text: 'L3 Component 7'),
                ],
              ),
            ),
          ),

          // Fixed header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.005), // Add 5px dynamic padding to the bottom
              child: const ProductsHeaderContent(),
            ),
          ),
        ],
      ),
    );
  }
}