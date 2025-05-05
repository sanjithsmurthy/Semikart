import 'package:flutter/material.dart';
import '../products/products_static.dart'; // Import the ProductsHeaderContent widget
import '../products/l2_tile.dart'; // Import the L2PageRedBox widget

class ProductsL3Page extends StatelessWidget {
  const ProductsL3Page({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Removed Scaffold widget
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

                // Step 2: Implement l2_page_redbox.dart with GestureDetector
                GestureDetector(
                  onTap: () {
                    // Navigate to L4 or handle tap
                    Navigator.of(context).pushNamed('l4'); // Assuming 'l4' is the route name
                    print('L3 Component 1 tapped!');
                  },
                  child: const RedBorderBox(text: 'L3 Component 1'),
                ),
                SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('l4');
                    print('L3 Component 2 tapped!');
                  },
                  child: const RedBorderBox(text: 'L3 Component 2'),
                ),
                SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('l4');
                    print('L3 Component 3 tapped!');
                  },
                  child: const RedBorderBox(text: 'L3 Component 3'),
                ),
                SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('l4');
                    print('L3 Component 4 tapped!');
                  },
                  child: const RedBorderBox(text: 'L3 Component 4'),
                ),
                SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('l4');
                    print('L3 Component 5 tapped!');
                  },
                  child: const RedBorderBox(text: 'L3 Component 5'),
                ),
                SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('l4');
                    print('L3 Component 6 tapped!');
                  },
                  child: const RedBorderBox(text: 'L3 Component 6'),
                ),
                SizedBox(height: screenHeight * 0.02), // Dynamically scalable spacing (2% of screen height)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('l4');
                    print('L3 Component 7 tapped!');
                  },
                  child: const RedBorderBox(text: 'L3 Component 7'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}