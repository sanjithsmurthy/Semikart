import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import '../../app_navigator.dart'; // Import AppNavigator to access the key
import 'products_static.dart'; // Import the ProductsHeaderContent widget
import 'l1_tile.dart'; // Import the L1Tile widget

class ProductsL1Page extends StatelessWidget {
  const ProductsL1Page({super.key});

  // Reference screen dimensions for scaling calculations
  static const double _refScreenWidth = 412.0;
  static const double _refScreenHeight = 917.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate scale factors (optional, can directly use fractions)
    // final widthScale = screenWidth / _refScreenWidth;
    // final heightScale = screenHeight / _refScreenHeight;

    // Helper function to scale width based on reference width
    double scaleWidth(double dimension) => screenWidth * (dimension / _refScreenWidth);

    // Helper function to scale height based on reference height
    double scaleHeight(double dimension) => screenHeight * (dimension / _refScreenHeight);

    return Column(
      children: [
        // Header
        const ProductsHeaderContent(), // Assuming this is already responsive or doesn't need scaling here
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('l1_products').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Error fetching products'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No products available'));
              }

              // Map Firestore documents to a list of categories
              final categories = snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>?; // Explicitly cast to Map<String, dynamic>
                if (data == null) {
                  return {
                    "id": doc.id,
                    "name": "Unknown", // Default to "Unknown" if data is null
                    "icon": "", // Default to an empty string if icon is null
                  };
                }
                return {
                  "id": doc.id,
                  "name": data["name"] ?? "Unknown", // Default to "Unknown" if name is null
                  "icon": data["icon"] ?? "", // Default to an empty string if icon is null
                };
              }).toList();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Use scaled height for spacing
                    SizedBox(height: scaleHeight(18)), // Approx screenHeight * 0.02 based on 917 ref height

                    // Grid-like layout with lines
                    Padding(
                      // Use scaled width for horizontal padding
                      padding: EdgeInsets.symmetric(horizontal: scaleWidth(16.5)), // Approx screenWidth * 0.04 based on 412 ref width
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
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        // *** Add Logging ***
                                        print("[ProductsL1Page] Tapped item: ${categories[firstIndex]["name"]}");
                                        final navigatorState = AppNavigator.productsNavKey.currentState;
                                        if (navigatorState == null) {
                                          print("[ProductsL1Page] Error: productsNavKey.currentState is NULL!");
                                        } else {
                                          print("[ProductsL1Page] productsNavKey.currentState is available. Pushing 'l2'...");
                                          navigatorState.pushNamed(
                                            'l2',
                                            arguments: {
                                              "l1DocId": categories[firstIndex]["id"],
                                              "l1Name": categories[firstIndex]["name"],
                                            },
                                          );
                                        }
                                      },
                                      child: L1Tile( // Assuming L1Tile handles its internal scaling
                                        iconPath: categories[firstIndex]["icon"]!,
                                        text: categories[firstIndex]["name"]!,
                                      ),
                                    ),
                                  ),
                                  _buildVerticalDivider(
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight,
                                    scaleWidth: scaleWidth,
                                    scaleHeight: scaleHeight,
                                  ),
                                  Expanded(
                                    child: secondIndex < categories.length
                                        ? GestureDetector(
                                            onTap: () {
                                              // *** Add Logging ***
                                              print("[ProductsL1Page] Tapped item: ${categories[secondIndex]["name"]}");
                                              final navigatorState = AppNavigator.productsNavKey.currentState;
                                              if (navigatorState == null) {
                                                print("[ProductsL1Page] Error: productsNavKey.currentState is NULL!");
                                              } else {
                                                print("[ProductsL1Page] productsNavKey.currentState is available. Pushing 'l2'...");
                                                navigatorState.pushNamed(
                                                  'l2',
                                                  arguments: {
                                                    "l1DocId": categories[secondIndex]["id"],
                                                    "l1Name": categories[secondIndex]["name"],
                                                  },
                                                );
                                              }
                                            },
                                            child: L1Tile( // Assuming L1Tile handles its internal scaling
                                              iconPath: categories[secondIndex]["icon"]!,
                                              text: categories[secondIndex]["name"]!,
                                            ),
                                          )
                                        : const SizedBox.shrink(), // Keep empty space if no second item
                                  ),
                                ],
                              ),
                              if (index < (categories.length / 2).ceil() - 1)
                                _buildHorizontalDivider(
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  scaleWidth: scaleWidth,
                                  scaleHeight: scaleHeight,
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: scaleHeight(20)), // Add some padding at the bottom
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget for a vertical divider, now using scaled dimensions
  Widget _buildVerticalDivider({
    required double screenWidth,
    required double screenHeight,
    required double Function(double) scaleWidth,
    required double Function(double) scaleHeight,
  }) {
    // Note: L1Tile height influences the required divider height.
    // Assuming L1Tile height is roughly 10% of screen height for this calculation.
    final tileHeight = screenHeight * 0.1; // Adjust if L1Tile height is different

    return Container(
      // Scale the space between items based on reference width
      width: scaleWidth(30), // 30 on a 412px wide screen
      // Scale the height based on an estimated tile height or a fixed scaled value
      height: tileHeight, // Match the approximate height of the L1Tile
      alignment: Alignment.center,
      child: const VerticalDivider(
        color: Color(0xFFA51414), // Red color (A51414)
        thickness: 1, // Keep thickness fixed or scale slightly if needed
        // thickness: max(1.0, scaleWidth(1)), // Example of scaled thickness with minimum
      ),
    );
  }

  // Widget for a horizontal divider, now using scaled dimensions
  Widget _buildHorizontalDivider({
    required double screenWidth,
    required double screenHeight,
    required double Function(double) scaleWidth,
    required double Function(double) scaleHeight,
  }) {
    return Container(
      // Scale the space between rows based on reference height
      height: scaleHeight(30), // 30 on a 917px high screen
      // Scale the width relative to the screen width (e.g., 90% of screen width)
      width: screenWidth * 0.9, // Keep relative width
      alignment: Alignment.center,
      child: const Divider(
        color: Color(0xFFA51414), // Red color (A51414)
        thickness: 1, // Keep thickness fixed or scale slightly if needed
         // thickness: max(1.0, scaleHeight(1)), // Example of scaled thickness with minimum
      ),
    );
  }
}
