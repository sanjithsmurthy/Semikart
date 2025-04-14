import 'package:flutter/material.dart';
import 'header.dart'; // Import the header.dart file
import 'products_static.dart'; // Import the products_static.dart file

class ProductsL1Page extends StatelessWidget {
  const ProductsL1Page({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // List of categories with their icons and names
    final List<Map<String, String>> categories = [
      {"icon": "public/assets/icon/circuit_protection.png", "name": "Circuit Protection"},
      {"icon": "public/assets/icon/connectors.png", "name": "Connectors"},
      {"icon": "public/assets/icon/electromechanical.png", "name": "Electromechanical"},
      {"icon": "public/assets/icon/embeded_solutions.png", "name": "Embedded Solutions"},
      {"icon": "public/assets/icon/enclosures.png", "name": "Enclosures"},
      {"icon": "public/assets/icon/engineering_development.png", "name": "Engineering Development Tools"},
      {"icon": "public/assets/icon/industrial_automation.png", "name": "Industrial Automation"},
      {"icon": "public/assets/icon/led_lighting.png", "name": "LED Lighting"},
      {"icon": "public/assets/icon/optoelectronics.png", "name": "Optoelectronics"},
      {"icon": "public/assets/icon/passive_components.png", "name": "Passive Components"},
      {"icon": "public/assets/icon/power.png", "name": "Power"},
      {"icon": "public/assets/icon/semiconductors.png", "name": "Semiconductors"},
      {"icon": "public/assets/icon/sensors.png", "name": "Sensors"},
      {"icon": "public/assets/icon/test_and_measurement.png", "name": "Test and Measurements"},
      {"icon": "public/assets/icon/thermal_management.png", "name": "Thermal Management"},
      {"icon": "public/assets/icon/tools_and_supplies.png", "name": "Tools and Suppliers"},
      {"icon": "public/assets/icon/wire_and_cable.png", "name": "Wire Cables"},
    ];

    return Scaffold(
      appBar: Header(
        title: 'Products', // Set the title for the header
        onBackPressed: () {
          Navigator.pop(context); // Handle back navigation
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Add the ProductsHeaderContent from products_static.dart
            const ProductsHeaderContent(),
            const SizedBox(height: 16), // Add spacing between header and grid

            // Grid-like layout with lines
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: ListView.builder(
                shrinkWrap: true, // Ensures the ListView takes only the required space
                physics: const NeverScrollableScrollPhysics(), // Disable ListView's scrolling
                itemCount: (categories.length / 2).ceil(),
                itemBuilder: (context, index) {
                  final int firstIndex = index * 2;
                  final int secondIndex = firstIndex + 1;

                  return Column(
                    children: [
                      Row(
                        children: [
                          _buildCategoryItem(
                            iconPath: categories[firstIndex]["icon"]!,
                            name: categories[firstIndex]["name"]!,
                            iconSize: screenWidth * 0.2, // Adjusted for responsiveness
                          ),
                          const SizedBox(width: 16), // Space between items
                          if (secondIndex < categories.length)
                            _buildCategoryItem(
                              iconPath: categories[secondIndex]["icon"]!,
                              name: categories[secondIndex]["name"]!,
                              iconSize: screenWidth * 0.2, // Adjusted for responsiveness
                            )
                          else
                            const Spacer(), // Empty space if no second item
                        ],
                      ),
                      const Divider(
                        color: Color(0xFFA51414), // Red color
                        thickness: 1, // Thickness of the line
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
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
          // Use Image.network to load the image
          Image.network(
            iconPath,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // Fallback widget in case the image fails to load
              return Icon(
                Icons.broken_image,
                size: iconSize,
                color: Colors.grey,
              );
            },
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
}
