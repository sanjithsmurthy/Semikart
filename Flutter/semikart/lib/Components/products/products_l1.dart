import 'package:flutter/material.dart';
import 'dart:developer'; // For logging
import '../../app_navigator.dart'; // Import AppNavigator to access the key
import 'products_static.dart'; // Import the ProductsHeaderContent widget
import 'l1_tile.dart'; // Import the L1Tile widget
import '../../services/database.dart'; // Import the DataBaseService for API calls

class ProductsL1Page extends StatefulWidget {
  const ProductsL1Page({super.key});

  @override
  State<ProductsL1Page> createState() => _ProductsL1PageState();
}

class _ProductsL1PageState extends State<ProductsL1Page> {
  // Reference screen dimensions for scaling calculations
  static const double _refScreenWidth = 412.0;
  static const double _refScreenHeight = 917.0;
  
  // Create an instance of DataBaseService
  final DataBaseService _databaseService = DataBaseService();
  
  // Future to hold the API call result
  late Future<List<Map<String, dynamic>>> _l1ProductsFuture;
  
  @override
  void initState() {
    super.initState();
    // Initialize the future in initState
    _l1ProductsFuture = _databaseService.getL1Products();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Helper function to scale width based on reference width
    double scaleWidth(double dimension) => screenWidth * (dimension / _refScreenWidth);

    // Helper function to scale height based on reference height
    double scaleHeight(double dimension) => screenHeight * (dimension / _refScreenHeight);

    return Column(
      children: [
        // Header
        const ProductsHeaderContent(), 
        
        // Replace StreamBuilder with FutureBuilder
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _l1ProductsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(
                  color: Color(0xFFA51414),
                ));
              }

              if (snapshot.hasError) {
                log('Error fetching L1 products: ${snapshot.error}');
                return Center(child: Text(
                  'Error fetching products: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No products available'));
              }

              // Use the data directly from the API response
              final categories = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Use scaled height for spacing
                    SizedBox(height: scaleHeight(18)),

                    // Grid-like layout with lines
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: scaleWidth(16.5)),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                                        log("[ProductsL1Page] Tapped item: ${categories[firstIndex]["name"]}");
                                        final navigatorState = AppNavigator.productsNavKey.currentState;
                                        if (navigatorState == null) {
                                          log("[ProductsL1Page] Error: productsNavKey.currentState is NULL!");
                                        } else {
                                          log("[ProductsL1Page] productsNavKey.currentState is available. Pushing 'l2'...");
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
                                        iconPath: categories[firstIndex]["icon"] ?? "",
                                        text: categories[firstIndex]["name"] ?? "Unknown",
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
                                              log("[ProductsL1Page] Tapped item: ${categories[secondIndex]["name"]}");
                                              final navigatorState = AppNavigator.productsNavKey.currentState;
                                              if (navigatorState == null) {
                                                log("[ProductsL1Page] Error: productsNavKey.currentState is NULL!");
                                              } else {
                                                log("[ProductsL1Page] productsNavKey.currentState is available. Pushing 'l2'...");
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
                                              iconPath: categories[secondIndex]["icon"] ?? "",
                                              text: categories[secondIndex]["name"] ?? "Unknown",
                                            ),
                                          )
                                        : const SizedBox.shrink(),
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
                    SizedBox(height: scaleHeight(20)),
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
  Widget _buildVerticalDivider({
    required double screenWidth,
    required double screenHeight,
    required double Function(double) scaleWidth,
    required double Function(double) scaleHeight,
  }) {
    final tileHeight = screenHeight * 0.1;

    return Container(
      width: scaleWidth(30),
      height: tileHeight,
      alignment: Alignment.center,
      child: const VerticalDivider(
        color: Color(0xFFA51414),
        thickness: 1,
      ),
    );
  }

  // Widget for a horizontal divider
  Widget _buildHorizontalDivider({
    required double screenWidth,
    required double screenHeight,
    required double Function(double) scaleWidth,
    required double Function(double) scaleHeight,
  }) {
    return Container(
      height: scaleHeight(30),
      width: screenWidth * 0.9,
      alignment: Alignment.center,
      child: const Divider(
        color: Color(0xFFA51414),
        thickness: 1,
      ),
    );
  }
}
