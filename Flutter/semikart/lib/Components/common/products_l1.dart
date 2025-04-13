import 'package:flutter/material.dart';
import 'header_withback.dart';

class ProductsL1Page extends StatelessWidget {
  const ProductsL1Page({super.key});

  @override
  Widget build(BuildContext context) {
    // List of categories with their icons and names
    final List<Map<String, String>> categories = [
      {"icon": "assets/icons/circuit_protection.png", "name": "Circuit Protection"},
      {"icon": "assets/icons/connectors.png", "name": "Connectors"},
      {"icon": "assets/icons/electromechanical.png", "name": "Electromechanical"},
      {"icon": "assets/icons/embedded_solutions.png", "name": "Embedded Solutions"},
      {"icon": "assets/icons/circuit_protection.png", "name": "Circuit Protection"},
      {"icon": "assets/icons/connectors.png", "name": "Connectors"},
      {"icon": "assets/icons/electromechanical.png", "name": "Electromechanical"},
      {"icon": "assets/icons/embedded_solutions.png", "name": "Embedded Solutions"},
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
            padding: const EdgeInsets.all(16.0),
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
          // Grid-like layout with lines
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // First Row
                  Row(
                    children: [
                      _buildCategoryItem(
                        iconPath: categories[0]["icon"]!,
                        name: categories[0]["name"]!,
                      ),
                      _buildVerticalDivider(),
                      _buildCategoryItem(
                        iconPath: categories[1]["icon"]!,
                        name: categories[1]["name"]!,
                      ),
                    ],
                  ),
                  _buildHorizontalDivider(),
                  // Second Row
                  Row(
                    children: [
                      _buildCategoryItem(
                        iconPath: categories[2]["icon"]!,
                        name: categories[2]["name"]!,
                      ),
                      _buildVerticalDivider(),
                      _buildCategoryItem(
                        iconPath: categories[3]["icon"]!,
                        name: categories[3]["name"]!,
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for a single category item
  Widget _buildCategoryItem({required String iconPath, required String name}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 40,
            height: 40,
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
  Widget _buildVerticalDivider() {
    return Container(
      width: 30, // Space between items
      height: 80, // Length of the vertical line
      alignment: Alignment.center,
      child: const VerticalDivider(
        color: Color(0xFFA51414), // Red color (A51414)
        thickness: 1, // Thickness of the line
      ),
    );
  }

  // Widget for a horizontal divider
  Widget _buildHorizontalDivider() {
    return Container(
      height: 30, // Space between rows
      width: double.infinity,
      alignment: Alignment.center,
      child: const Divider(
        color: Color(0xFFA51414), // Red color (A51414)
        thickness: 1, // Thickness of the line
        indent: 16, // Indent from the left
        endIndent: 16, // Indent from the right
      ),
    );
  }
}
