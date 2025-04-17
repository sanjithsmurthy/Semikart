import 'package:flutter/material.dart';
import '../products/products_static.dart'; // Import the ProductsHeaderContent widget
import '../products/l2_page_redbox.dart'; // Import the L2PageRedBox widget
class ProductsL3Page extends StatelessWidget {
  const ProductsL3Page({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          // Header
          ProductsHeaderContent(),

          Expanded(
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
        ],
      ),
    );
  }
}