import 'package:flutter/material.dart';
import '../common/search_bar.dart' as custom; // Import SearchBar with alias
import 'popular_categories_grid.dart';
import 'bom_rfq.dart'; // Import BomRfqCard

// Renamed to avoid conflict and clarify purpose
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Return only the content, not a Scaffold
    return Container(
      // Apply the gradient background
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFCD5C5C), // Darker red
            Color(0xFFE09999), // Medium red
            Color(0xFFEFCCCC), // Lighter red
            Color(0xFFF7E6E6), // Very light red
            Color(0xFFFFFFFF), // White
          ],
          stops: [0.18, 0.56, 0.79, 0.85, 1.0], // Gradient stops
        ),
      ),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          // Ensure content can fill the screen height if needed, but allow scrolling
          constraints: BoxConstraints(
            minHeight: screenHeight - (Scaffold.of(context).appBarMaxHeight ?? kToolbarHeight) - kBottomNavigationBarHeight, // Adjust for AppBar and BottomNav
          ),
          child: Padding(
            // Add padding if needed, or keep existing structure
            padding: EdgeInsets.only(bottom: screenHeight * 0.05), // Example padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container for top section (text + search + stats)
                Container(
                  width: screenWidth * 0.95, // Slightly wider
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, // Adjusted padding
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.02, // Reduced top padding
                          left: screenWidth * 0.05,
                          right: screenWidth * 0.05,
                        ),
                        child: Text(
                          'One stop shop for all your electronic components!',
                          style: TextStyle(
                            
                            fontSize: screenWidth * 0.045, // Adjusted font size
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4D0102), // Dark red text
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      const custom.SearchBar(
                        hintText: 'Search',
                        backgroundColor: Colors.white,
                        iconColor: Color(0xFFA51414), // Semikart red
                        borderRadius: 20.0,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      // Stats Column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _StatCard(
                            iconPath: 'public/assets/icon/Banner Icon 1.png',
                            label: '35+',
                            description: 'Years Of Sales & Marketing Experience',
                            screenWidth: screenWidth,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _StatCard(
                            iconPath: 'public/assets/icon/Banner Icon 2.png',
                            label: '8M+',
                            description: 'Electronic Components Live Inventory',
                            screenWidth: screenWidth,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _StatCard(
                            iconPath: 'public/assets/icon/Banner Icon 3.png',
                            label: '7000+',
                            description: 'Electronic Manufacturers',
                            screenWidth: screenWidth,
                          ),
                          SizedBox(height: screenHeight * 0.02),
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
                SizedBox(height: screenHeight * 0.03), // Adjusted spacing
                // Explore Categories Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Explore Our Popular Categories',
                        style: TextStyle(
                          
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        'Explore a wide selection of connectors, semiconductors, all other electronic parts.',
                        style: TextStyle(
                          
                          fontSize: screenWidth * 0.035, // Adjusted font size
                          fontWeight: FontWeight.normal,
                          color: Colors.black54, // Slightly lighter text
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Popular Categories Grid
                PopularCategoriesGrid(
                  onViewAll: () {
                    print('View All clicked');
                    // Add navigation logic if needed
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                // BOM RFQ Card
                const BomRfqCard(),
                // Add SizedBox at the end if needed for bottom spacing
                // SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget for Stats Section (_StatCard remains the same)
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          iconPath,
          height: screenWidth * 0.1,
          width: screenWidth * 0.1,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 40), // Add error builder
        ),
        SizedBox(width: screenWidth * 0.04), // Adjusted spacing
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87, // Slightly darker text
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}