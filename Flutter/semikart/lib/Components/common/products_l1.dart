import 'package:flutter/material.dart';
import 'header.dart'; // Import the Header widget
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
        showBackButton: true, // Show the back button
        title: 'Products', // Set the title
        onBackPressed: () {
          Navigator.pop(context); // Navigate back to the previous page
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
                    SizedBox(height: screenHeight * 0.02), // Add dynamic spacing between header and grid

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
                                  iconSize: screenWidth * 0.1, // Adjusted for responsiveness
                                ),
                                _buildVerticalDivider(screenHeight: screenHeight),
                                if (secondIndex < categories.length)
                                  _buildCategoryItem(
                                    iconPath: categories[secondIndex]["icon"]!,
                                    name: categories[secondIndex]["name"]!,
                                    iconSize: screenWidth * 0.1, // Adjusted for responsiveness
                                  )
                                else
                                  const Spacer(), // Empty space if no second item
                              ],
                            ),
                            if (index < (categories.length / 2).ceil() - 1)
                              _buildHorizontalDivider(screenWidth: screenWidth),
                          ],
                        );
                      },
                    ),
                  ),
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
          Image.asset(
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
