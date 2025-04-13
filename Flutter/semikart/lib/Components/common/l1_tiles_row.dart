import 'package:flutter/material.dart';
import 'header_withback.dart';

class ProductsL1Page extends StatelessWidget {
  const ProductsL1Page({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // List of categories with their icons and names
    final List<Map<String, String>> categories = [
      {"icon": "whatsapp.svg", "name": "Circuit Protection"},
      {"icon": "assets/icons/connectors.png", "name": "Connectors"},
    ];

    return Scaffold(
      appBar: CombinedAppBar(
        title: 'Products', // Set your product category title here
        onBackPressed: () {
          Navigator.pop(context); // Standard back navigation
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Heading
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: const Text(
              'Electronic Components Categories Line Card',
              style: TextStyle(
                color: Color(0xFFA51414), // Red color (A51414)
                fontSize: 20, // Font size 20px
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // First row with vertical and horizontal lines
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildCategoryItem(
                        iconPath: categories[0]["icon"]!,
                        name: categories[0]["name"]!,
                        iconSize: screenWidth * 0.1,
                      ),
                      _buildVerticalDivider(screenHeight: screenHeight),
                      _buildCategoryItem(
                        iconPath: categories[1]["icon"]!,
                        name: categories[1]["name"]!,
                        iconSize: screenWidth * 0.1,
                      ),
                    ],
                  ),
                  _buildHorizontalDivider(screenWidth: screenWidth),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for a single category item
  Widget _buildCategoryItem({
    required String iconPath,
    required String name,
    required double iconSize,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8), // Spacing between icon and text
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Widget for a vertical divider
  Widget _buildVerticalDivider({required double screenHeight}) {
    return Container(
      width: 30, // Space between items
      height: screenHeight * 0.1, // Length of the vertical line
      alignment: Alignment.center,
      child: const VerticalDivider(
        color: Color(0xFFA51414), // Red color (A51414)
        thickness: 1, // Thickness of the line
      ),
    );
  }

  // Widget for a horizontal divider
  Widget _buildHorizontalDivider({required double screenWidth}) {
    return Container(
      height: 30, // Space between rows
      width: screenWidth * 0.9, // Length of the horizontal line
      alignment: Alignment.center,
      child: const Divider(
        color: Color(0xFFA51414), // Red color (A51414)
        thickness: 1, // Thickness of the line
      ),
    );
  }
}
