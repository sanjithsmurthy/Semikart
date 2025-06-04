import 'package:flutter/material.dart';
import 'dart:developer'; // For logging
import 'dart:convert'; // Added for jsonDecode
import 'package:http/http.dart' as http; // Added for http requests
import '../../app_navigator.dart'; // Import AppNavigator for L4 navigation
import 'products_static.dart'; // Import the ProductsHeaderContent widget
import 'l1_tile.dart'; // Import the L1Tile widget
// import '../../services/database.dart'; // Import the DataBaseService for API calls - Commented out

class ProductsL1Page extends StatefulWidget {
  const ProductsL1Page({super.key});

  @override
  State<ProductsL1Page> createState() => _ProductsL1PageState();
}

class _ProductsL1PageState extends State<ProductsL1Page> {
  // Reference screen dimensions for scaling calculations
  static const double _refScreenWidth = 412.0;
  static const double _refScreenHeight = 917.0;

  // Create an instance of DataBaseService - Commented out
  // final DataBaseService _databaseService = DataBaseService();

  // Future to hold the API call result
  late Future<List<Map<String, dynamic>>> _l1ProductsFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future in initState
    _l1ProductsFuture = _fetchL1Categories(); // Changed to local fetch
  }

  // Fetch L1 categories
  Future<List<Map<String, dynamic>>> _fetchL1Categories() async {
    final url = Uri.parse('http://172.16.2.5:8080/semikartapi/productHierarchy');
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['mainCategories'] != null) {
          List<dynamic> mainCategories = data['mainCategories'];
          return mainCategories.map((category) {
            String imageUrl = category['imageUrl'] ?? '';
            // Ensure imageUrl is a full path
            if (imageUrl.startsWith('/')) {
              imageUrl = 'http://172.16.2.5:8080$imageUrl';
            }
            return {
              'id': category['mainCategoryId'],
              'name': category['mainCategoryName'] ?? 'Unnamed Category',
              'icon': imageUrl,
            };
          }).toList();
        } else {
          log('L1 API call successful but status not success or no mainCategories: ${response.body}');
          return []; // Return empty list or throw error
        }
      } else {
        log('Failed to load L1 categories, status code: ${response.statusCode}');
        return []; // Return empty list or throw error
      }
    } catch (e) {
      log('Error fetching L1 categories: $e');
      return []; // Return empty list or throw error
    }
  }

  // Fetch L2 categories for a given L1 id
  Future<List<Map<String, dynamic>>> fetchL2Categories(int l1Id) async {
    final url = Uri.parse('http://172.16.2.5:8080/semikartapi/productHierarchy?main_category_id=$l1Id');
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 30)); // Increased timeout
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['mainSubCategories'] != null) {
          return List<Map<String, dynamic>>.from(data['mainSubCategories']);
        }
      }
    } catch (e) {
      log('Timeout or error fetching L2 categories: $e');
    }
    return [];
  }
  // Fetch L3 categories for a given L2 id
  Future<List<Map<String, dynamic>>> fetchL3Categories(int l2Id) async {
    final url = Uri.parse('http://172.16.2.5:8080/semikartapi/productHierarchy?main_sub_category_id=$l2Id');
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['categories'] != null) {
          // Parse the categories as per the provided response format
          return List<Map<String, dynamic>>.from(
            (data['categories'] as List).map((cat) => {
              'categoryId': cat['categoryId'],
              'categoryName': cat['categoryName'],
            })
          );
        }
      }
    } catch (e) {
      log('Timeout or error fetching L3 categories: $e');
    }
    return [];
  }
  // Fetch L4 products for a given L3 category id
  Future<List<Map<String, dynamic>>> fetchL4Products(int categoryId, {int page = 1, int pageSize = 20}) async {
    final url = Uri.parse('http://172.16.2.5:8080/semikartapi/paginatedProductCatalog?categoryId=$categoryId&page=$page&pageSize=$pageSize');
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['products'] != null) {
          return List<Map<String, dynamic>>.from(data['products']);
        } else {
          log('L4 API call successful but status not success or no products: ${response.body}');
          return [];
        }
      } else {
        log('Failed to load L4 products, status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching L4 products: $e');
      return [];
    }
  }


  // Show L2 categories in a modal bottom sheet
  void _showL2Categories(BuildContext context, int l1Id, String l1Name) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (modalContext) { // Renamed context to modalContext to avoid conflict
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchL2Categories(l1Id),
          builder: (context, snapshot) { // This context is fine
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator(color: Color(0xFFA51414))),
              );
            }
            if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
              return SizedBox(
                height: 200,
                child: Center(child: Text(snapshot.hasError ? 'Error loading L2 categories' : 'No L2 categories found')),
              );
            }
            final l2Categories = snapshot.data!;
            return Container(
              color: Colors.white, // Set background to white
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l1Name, // L1 Category Name
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA51414), // Set breadcrumb color to a51414
                      ),
                    ),
                    const Divider(height: 10),
                    Expanded( // Make the list scrollable if content overflows
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: l2Categories.length,
                        itemBuilder: (context, index) {
                          final l2Cat = l2Categories[index];
                          return ListTile(
                            dense: true, // Makes the tile more compact
                            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 8), // Reduce vertical space
                            title: Text(
                              l2Cat['mainSubCategoryName'] ?? 'Unnamed L2 Category',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: Color(0xFFA51414), // Set arrow color to a51414
                            ),
                            onTap: () {
                              Navigator.pop(modalContext); // Close L2 modal
                              _showL3Categories(
                                this.context,
                                l2Cat['mainSubCategoryId'],
                                l2Cat['mainSubCategoryName'] ?? 'Unnamed L2 Category',
                                l1Name,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Show L3 categories in a modal bottom sheet
  void _showL3Categories(BuildContext context, int l2Id, String l2Name, String l1Name) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (modalContext) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchL3Categories(l2Id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator(color: Color(0xFFA51414))),
              );
            }
            if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
              return SizedBox(
                height: 200,
                child: Center(child: Text(snapshot.hasError ? 'Error loading L3 categories' : 'No L3 categories found')),
              );
            }
            final l3Categories = snapshot.data!;
            return Container(
              color: Colors.white, // Set background to white
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$l1Name > $l2Name', // Breadcrumb: L1 > L2
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA51414), // Set breadcrumb color to a51414
                      ),
                    ),
                    const Divider(height: 10),
                     Expanded( // Make the list scrollable
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: l3Categories.length,
                        itemBuilder: (context, index) {
                          final l3Cat = l3Categories[index];
                          return ListTile(
                            dense: true, // Makes the tile more compact
                            visualDensity: VisualDensity.compact, // Even less vertical space
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8), // Minimal vertical space
                            title: Text(
                              l3Cat['categoryName'] ?? 'Unnamed L3 Category',
                              style: const TextStyle(
                                fontSize: 13, // Small text
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: Color(0xFFA51414), // Set arrow color to a51414
                            ),
                            onTap: () {
                              Navigator.pop(modalContext); // Close L3 modal
                              log('Tapped L3: ${l3Cat['categoryName']} (ID: ${l3Cat['categoryId']})');
                              
                              // Prepare navigation arguments
                              final navigationArgs = {
                                'categoryId': l3Cat['categoryId'],
                                'categoryName': l3Cat['categoryName'],
                                'l2Name': l2Name,
                                'l1Name': l1Name,
                              };
                              
                              log('L3 Navigation: Prepared args: $navigationArgs');
                              log('L3 Navigation: categoryId type: ${l3Cat['categoryId'].runtimeType}');
                              
                              // Navigate to L4 products page with the categoryId
                              AppNavigator.pushProductsL4(arguments: navigationArgs);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
                    // SizedBox(height: scaleHeight(18)), // Removed top padding

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
                                        final l1Id = categories[firstIndex]["id"];
                                        final l1Name = categories[firstIndex]["name"] ?? "Unknown";
                                        _showL2Categories(this.context, l1Id, l1Name); // Use this.context
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
                                              final l1Id = categories[secondIndex]["id"];
                                              final l1Name = categories[secondIndex]["name"] ?? "Unknown";
                                               _showL2Categories(this.context, l1Id, l1Name); // Use this.context
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
      width: scaleWidth(25),
      height: tileHeight,
      alignment: Alignment.center,
      child: Container(
        width: 1,
        height: tileHeight * 0.85,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Color(0xFFA51414),
              Colors.transparent,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
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
      height: scaleHeight(13),
      width: screenWidth * 0.9, // Increased from 0.9 to 0.98 for longer line
      alignment: Alignment.center,
      child: Container(
        height: 1,
        width: screenWidth * 0.92, // Increased from 0.8 to 0.92 for longer line
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.transparent,
              Color(0xFFA51414),
              Colors.transparent,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }
}
