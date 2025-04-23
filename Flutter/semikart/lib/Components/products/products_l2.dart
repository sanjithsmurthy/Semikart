import 'package:flutter/material.dart';
import '../products/products_static.dart'; // Assuming ProductsHeaderContent is here
import '../products/l2_page_redbox.dart'; // Already scaled
// import '../products/products_l3.dart'; // Not used directly in this snippet

class ProductsL2Page extends StatelessWidget {
  const ProductsL2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Reference screen dimensions
    // const double refWidth = 412.0; // Not used directly here
    const double refHeight = 917.0;

    // Calculate scaling factors
    // final double widthScale = screenWidth / refWidth;
    final double heightScale = screenHeight / refHeight;

    // Scaled dimensions
    final double verticalSpacing = 18.0 * heightScale; // ref: 18px

    // Return the Column directly, NO Scaffold here
    return Column(
      children: [
        // Header
        const ProductsHeaderContent(), // Assuming this handles its own scaling
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: verticalSpacing), // Use scaled spacing

                // Step 2: Implement l2_page_redbox.dart
                GestureDetector(
                  onTap: () {
                    // TODO: Pass actual L2 category identifier
                    Navigator.of(context).pushNamed('l3', arguments: 'L2 Component 1');
                  },
                  child: const RedBorderBox(text: 'L2 Component 1'), // RedBorderBox is already scaled
                ),
                SizedBox(height: verticalSpacing), // Use scaled spacing
                GestureDetector( // Added GestureDetector
                  onTap: () {
                     // TODO: Pass actual L2 category identifier
                    Navigator.of(context).pushNamed('l3', arguments: 'L2 Component 2');
                  },
                  child: const RedBorderBox(text: 'L2 Component 2'),
                ),
                SizedBox(height: verticalSpacing), // Use scaled spacing
                GestureDetector( // Added GestureDetector
                  onTap: () {
                     // TODO: Pass actual L2 category identifier
                    Navigator.of(context).pushNamed('l3', arguments: 'L2 Component 3');
                  },
                  child: const RedBorderBox(text: 'L2 Component 3'),
                ),
                SizedBox(height: verticalSpacing), // Use scaled spacing
                GestureDetector( // Added GestureDetector
                  onTap: () {
                     // TODO: Pass actual L2 category identifier
                    Navigator.of(context).pushNamed('l3', arguments: 'L2 Component 4');
                  },
                  child: const RedBorderBox(text: 'L2 Component 4'),
                ),
                SizedBox(height: verticalSpacing), // Use scaled spacing
                GestureDetector( // Added GestureDetector
                  onTap: () {
                     // TODO: Pass actual L2 category identifier
                    Navigator.of(context).pushNamed('l3', arguments: 'L2 Component 5');
                  },
                  child: const RedBorderBox(text: 'L2 Component 5'),
                ),
                SizedBox(height: verticalSpacing), // Use scaled spacing
                GestureDetector( // Added GestureDetector
                  onTap: () {
                     // TODO: Pass actual L2 category identifier
                    Navigator.of(context).pushNamed('l3', arguments: 'L2 Component 6');
                  },
                  child: const RedBorderBox(text: 'L2 Component 6'),
                ),
                SizedBox(height: verticalSpacing), // Use scaled spacing
                GestureDetector( // Added GestureDetector
                  onTap: () {
                     // TODO: Pass actual L2 category identifier
                    Navigator.of(context).pushNamed('l3', arguments: 'L2 Component 7');
                  },
                  child: const RedBorderBox(text: 'L2 Component 7'),
                ),
                 SizedBox(height: verticalSpacing), // Add final spacing at the bottom
              ],
            ),
          ),
        ),
      ],
    );
  }
}