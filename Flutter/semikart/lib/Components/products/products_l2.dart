// products_l2.dart - Final working solution receiving L1 ID and querying by DocumentReference
import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Replace Firestore with Dio
import 'dart:developer'; // For logging
import 'l2_tile.dart'; // Import the L2Tile widget
import 'products_static.dart'; // Import the static header content
import '../../services/database.dart'; // Import the DataBaseService for API calls

class ProductsL2Page extends StatefulWidget {
  const ProductsL2Page({super.key});

  @override
  State<ProductsL2Page> createState() => _ProductsL2PageState();
}

class _ProductsL2PageState extends State<ProductsL2Page> {
  // Updated to use API instead of Firestore
  final DataBaseService _databaseService = DataBaseService();
  bool _isLoading = false;

  // Helper method to create a sample L2 category for testing - now uses API
  Future<void> _createSampleL2Category(String l1Id) async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      await _databaseService.addL2Category(
        l1Id: l1Id,
        name: 'Sample Subcategory (${DateTime.now().toString().substring(0, 16)})'
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sample subcategory created!')),
        );
      }
    } catch (e) {
      log('Error creating sample category: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating sample subcategory: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // --- Dynamic scaling (unchanged) ---
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const double refWidth = 412.0;
    const double refHeight = 917.0;

    // Padding
    final double dynamicPagePadding = screenWidth * (16 / refWidth);
    final double dynamicItemBottomPadding = screenHeight * (16 / refHeight);

    // Font Sizes
    final double dynamicErrorFontSize = screenHeight * (16 / refHeight);
    final double dynamicButtonFontSize = screenHeight * (14 / refHeight);

    // Spacing
    final double dynamicSpacingMedium = screenHeight * (20 / refHeight);
    final double dynamicSpacingSmall = screenHeight * (10 / refHeight);
    // --- End dynamic scaling ---

    // Safely retrieve the arguments passed from the L1 page
    final Object? routeArgs = ModalRoute.of(context)?.settings.arguments;

    // Validate arguments - expect a Map<String, dynamic>
    if (routeArgs == null || !(routeArgs is Map<String, dynamic>)) {
      return Center(child: Text(
        'Navigation Error: No category information provided',
        style: TextStyle(fontSize: dynamicErrorFontSize),
        textAlign: TextAlign.center,
      ));
    }

    final Map<String, dynamic> args = routeArgs;
    final String? l1DocId = args["l1DocId"] as String?;
    final String? l1Name = args["l1Name"] as String?;

    // Validate L1 document ID
    if (l1DocId == null || l1DocId.isEmpty) {
       return Center(child: Text(
         'Navigation Error: Invalid L1 category ID provided',
         style: TextStyle(fontSize: dynamicErrorFontSize),
         textAlign: TextAlign.center,
       ));
    }

    // Fetch L2 products from the API instead of using Firestore stream
    return Column(
      children: [
        // Add the fixed header at the top (unchanged)
        const ProductsHeaderContent(),

        // Use Expanded and FutureBuilder instead of StreamBuilder
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            // Use the DataBaseService to fetch L2 products by L1 ID
            future: _databaseService.getL2ProductsByL1Id(l1DocId),
            builder: (context, l2Snapshot) {
              if (l2Snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (l2Snapshot.hasError) {
                return Center(child: Text(
                  'Error fetching L2 products: ${l2Snapshot.error}',
                  style: TextStyle(fontSize: dynamicErrorFontSize),
                  textAlign: TextAlign.center,
                ));
              }

              final l2Categories = l2Snapshot.data ?? [];
              
              if (l2Categories.isEmpty) {
                // Display 'No subcategories' message and buttons
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(dynamicPagePadding),
                        child: Text(
                          'No subcategories found for "${l1Name ?? 'this category'}".',
                          style: TextStyle(fontSize: dynamicErrorFontSize),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: dynamicSpacingMedium),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: dynamicButtonFontSize)
                        ),
                        onPressed: _isLoading 
                            ? null 
                            : () => _createSampleL2Category(l1DocId),
                        child: _isLoading 
                            ? const SizedBox(
                                width: 20, 
                                height: 20, 
                                child: CircularProgressIndicator(strokeWidth: 2)
                              )
                            : const Text('Create Sample Subcategory'),
                      ),
                      SizedBox(height: dynamicSpacingSmall),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: dynamicButtonFontSize)
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Go Back'),
                      ),
                    ],
                  ),
                );
              }

              // ListView of L2 categories (no changes needed here except the data source)
              return ListView.builder(
                padding: EdgeInsets.all(dynamicPagePadding),
                itemCount: l2Categories.length,
                itemBuilder: (context, index) {
                  final item = l2Categories[index];
                  final id = item["id"]?.toString() ?? "";
                  final name = item["name"] as String? ?? "Unknown";
                  
                  return Padding(
                    padding: EdgeInsets.only(bottom: dynamicItemBottomPadding),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          'l3',
                          arguments: {
                            "l2DocId": id,
                            "l2Name": name,
                            "l1DocId": l1DocId,
                            "l1Name": l1Name,
                          },
                        );
                      },
                      child: RedBorderBox(text: name),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}