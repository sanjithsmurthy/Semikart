import 'package:flutter/material.dart';
import '../common/header.dart'; // Import Header
import '../common/search_builtin.dart' as custom; // Import SearchBar with alias
import 'popular_categories_grid.dart';
import 'bom_rfq.dart'; // Import BomRfqCard
import 'manufacturers.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: const Header(
          onLogoTap: null, // You can define a callback if needed
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFCD5C5C), // Gradient start color
                Color(0xFFE09999),
                Color(0xFFEFCCCC),
                Color(0xFFF7E6E6),
                Color(0xFFFFFFFF), // Gradient end color
              ],
              stops: [0.18, 0.56, 0.79, 0.85, 1.0], // Gradient stops
            ),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight, // Ensure the gradient covers the full height
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.2), // Add 20% bottom padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Align content center horizontally
                  children: [
                    // Center the Banner Section
                    Center(
                      child: Container(
                        width: screenWidth * 0.9, // Set the width to 90% of the screen
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.07, // Increased horizontal padding (7% of screen width)
                          vertical: screenHeight * 0.02, // 2% vertical padding
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center, // Align content center horizontally
                          children: [
                            // Title
                            Padding(
                              padding: EdgeInsets.only(
                                top: screenHeight * 0.035, // 40px dynamically scalable
                                left: screenWidth * 0.07, // 54px dynamically scalable
                                right: screenWidth * 0.07, // 54px dynamically scalable
                              ),
                              child: Text(
                                'One stop shop for all your electronic components!',
                                style: TextStyle(
                                  fontFamily: 'Product Sans', // Use Product Sans Regular font
                                  fontSize: screenWidth * 0.0453, // Dynamically scalable font size (~24px)
                                  fontWeight: FontWeight.bold, // Bold weight
                                  color: const Color(0xFF4D0102), // Hex color #4D0102
                                ),
                                textAlign: TextAlign.center, // Center align the text
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03), // Add 30px dynamic spacing above the search bar
                            // Search Bar
                            const custom.SearchBar(
                              hintText: 'Search',
                              backgroundColor: Colors.white,
                              iconColor: Color(0xFFA51414),
                              borderRadius: 20.0,
                            ),
                            SizedBox(height: screenHeight * 0.03), // Add 30px dynamic spacing below the search bar
                            // Stats Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center, // Align stat cards center horizontally
                              children: [
                                _StatCard(
                                  iconPath: 'public/assets/icon/Banner Icon 1.png',
                                  label: '35+',
                                  description: 'Years Of Sales & Marketing Experience',
                                  screenWidth: screenWidth,
                                ),
                                SizedBox(height: screenHeight * 0.02), // Dynamic spacing
                                _StatCard(
                                  iconPath: 'public/assets/icon/Banner Icon 2.png',
                                  label: '8M+',
                                  description: 'Electronic Components Live Inventory',
                                  screenWidth: screenWidth,
                                ),
                                SizedBox(height: screenHeight * 0.02), // Dynamic spacing
                                _StatCard(
                                  iconPath: 'public/assets/icon/Banner Icon 3.png',
                                  label: '7000+',
                                  description: 'Electronic Manufacturers',
                                  screenWidth: screenWidth,
                                ),
                                SizedBox(height: screenHeight * 0.02), // Dynamic spacing
                                _StatCard(
                                  iconPath: 'public/assets/icon/Banner Icon 4.png',
                                  label: '10+',
                                  description: 'Live Inventory Suppliers',
                                  screenWidth: screenWidth,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05), // Add spacing after the stats section
                    // Explore Categories Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Explore Our Popular Categories',
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontSize: screenWidth * 0.045, // Dynamically scalable font size (~20px)
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenHeight * 0.02), // Add spacing below the heading
                          Text(
                            'Explore a wide selection of connectors, semiconductors, all other electronic parts.',
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontSize: screenWidth * 0.03, // Dynamically scalable font size (~16px)
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05), // Add spacing after the categories section
                    PopularCategoriesGrid(
                      onViewAll: () {
                        // Navigate to another page
                        print('View All clicked');
                      },
                    ),
                    SizedBox(height: screenHeight * 0.05), // Add 50px dynamic spacing
                    // Add BOM_RFQ Card
                    const BomRfqCard(),
                    SizedBox(height: screenHeight * 0.05), // Add 50px dynamic spacing after BOM_RFQ Card
                    // Add Manufacturers Marquee
                    ManufacturerCarousel(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget for Stats Section
class _StatCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final String description;
  final double screenWidth;

  const _StatCard({
    required this.iconPath,
    required this.label,
    required this.description,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center align the stat card horizontally
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon
        Image.asset(
          iconPath,
          height: screenWidth * 0.1, // Dynamically scale icon size
          width: screenWidth * 0.1,
          fit: BoxFit.contain,
        ),
        SizedBox(width: screenWidth * 0.05), // Dynamic spacing
        // Text Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18, // Match font size in the image
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14, // Match font size in the image
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}