import 'package:flutter/material.dart';
import '../common/custom_base_scaffold.dart'; // Import CustomBaseScaffold
import '../common/search_builtin.dart' as custom; // Import SearchBar with alias
import 'popular_categories_grid.dart';
import 'bom_rfq.dart'; // Import BomRfqCard

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return CustomBaseScaffold(
      selectedIndex: 0, // Home screen selected in the bottom nav
      onNavTap: (index) {
        // Handle navigation
        if (index == 1) {
          Navigator.pushNamed(context, '/products');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/search');
        } else if (index == 3) {
          Navigator.pushNamed(context, '/cart');
        } else if (index == 4) {
          Navigator.pushNamed(context, '/profile');
        }
      },
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCD5C5C),
              Color(0xFFE09999),
              Color(0xFFEFCCCC),
              Color(0xFFF7E6E6),
              Color(0xFFFFFFFF),
            ],
            stops: [0.18, 0.56, 0.79, 0.85, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight,
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: screenWidth * 0.9,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.07,
                        vertical: screenHeight * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.035,
                              left: screenWidth * 0.07,
                              right: screenWidth * 0.07,
                            ),
                            child: Text(
                              'One stop shop for all your electronic components!',
                              style: TextStyle(
                                fontFamily: 'Product Sans',
                                fontSize: screenWidth * 0.0453,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4D0102),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          const custom.SearchBar(
                            hintText: 'Search',
                            backgroundColor: Colors.white,
                            iconColor: Color(0xFFA51414),
                            borderRadius: 20.0,
                          ),
                          SizedBox(height: screenHeight * 0.03),
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
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Explore Our Popular Categories',
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Explore a wide selection of connectors, semiconductors, all other electronic parts.',
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  PopularCategoriesGrid(
                    onViewAll: () {
                      print('View All clicked');
                    },
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  const BomRfqCard(),
                  SizedBox(height: screenHeight * 0.05),
                ],
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          iconPath,
          height: screenWidth * 0.1,
          width: screenWidth * 0.1,
          fit: BoxFit.contain,
        ),
        SizedBox(width: screenWidth * 0.05),
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