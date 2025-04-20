import 'package:flutter/material.dart';
import '../products/products_static.dart';
import '../products/l2_page_redbox.dart';
import '../products/products_l3.dart';

class ProductsL2Page extends StatelessWidget {
  const ProductsL2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Return the Column directly, NO Scaffold here
    return Column(
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
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('l3');

                  },
                  child: const RedBorderBox(text: 'L2 Component 1'),
                ),
                SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                const RedBorderBox(text: 'L2 Component 2'),
                SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                const RedBorderBox(text: 'L2 Component 3'),
                SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                const RedBorderBox(text: 'L2 Component 4'),
                SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                const RedBorderBox(text: 'L2 Component 5'),
                SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                const RedBorderBox(text: 'L2 Component 6'),
                SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                const RedBorderBox(text: 'L2 Component 7'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}