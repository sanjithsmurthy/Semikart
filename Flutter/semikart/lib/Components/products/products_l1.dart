import 'package:flutter/material.dart';
import 'products_static.dart'; // Import the ProductsHeaderContent widget
import 'l1_tile.dart'; // Import the L1Tile widget

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
                SizedBox(height: screenHeight * 0.02), // Add spacing between header and grid

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
                              Expanded( // Keep Expanded to ensure items take equal width
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigate directly to ProductsL2Page for any category tap
                                    Navigator.of(context).pushNamed('l2');
                                  },
                                  child: L1Tile(
                                    iconPath: categories[firstIndex]["icon"]!,
                                    text: categories[firstIndex]["name"]!,
                                  ),
                                ),
                              ),
                              _buildVerticalDivider(screenHeight: screenHeight),
                              Expanded( // Keep Expanded to ensure items take equal width
                                child: secondIndex < categories.length
                                    ? GestureDetector(
                                        onTap: () {
                                          // Navigate directly to ProductsL2Page for any category tap
                                          Navigator.of(context).pushNamed('l2');
                                        },
                                        child: L1Tile(
                                          iconPath: categories[secondIndex]["icon"]!,
                                          text: categories[secondIndex]["name"]!,
                                        ),
                                      )
                                    : const SizedBox.shrink(), // Use SizedBox.shrink() for empty space
                              ),
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
      ],
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
