import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import '../../app_navigator.dart'; // Import AppNavigator to access the key
import 'products_static.dart'; // Import the ProductsHeaderContent widget
import 'l1_tile.dart'; // Import the L1Tile widget

class ProductsL1Page extends StatelessWidget {
  const ProductsL1Page({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // Header
        ProductsHeaderContent(),
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
                                      child: L1Tile(
                                        iconPath: categories[firstIndex]["icon"]!,
                                        text: categories[firstIndex]["name"]!,
                                      ),
                                    ),
                                  ),
                                  _buildVerticalDivider(screenHeight: screenHeight),
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
                                            child: L1Tile(
                                              iconPath: categories[secondIndex]["icon"]!,
                                              text: categories[secondIndex]["name"]!,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
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
              );
            },
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
