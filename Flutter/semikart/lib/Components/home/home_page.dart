import 'package:flutter/material.dart';
import '../common/search_bar.dart' as custom;
import 'popular_categories_grid.dart';
import 'bom_rfq.dart';
import '../products/products_l1.dart';
import '../../base_scaffold.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white, // whole page background to white
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gradient Header Section
            Container(
              width: screenWidth,
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
          stops: [0.4, 0.7, 0.8, 0.85, 1.0],
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'One stop shop for all your electronic components!',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4D0102),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const custom.SearchBar(
                    hintText: 'Search',
                    backgroundColor: Colors.white,
                    iconColor: Color(0xFFA51414),
                    borderRadius: 20.0,
                  ),
                  SizedBox(height: screenHeight * 0.03),
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
            ),

            // White Background Content Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.03,
              ),
              child: Column(
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
                      fontSize: screenWidth * 0.035,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  PopularCategoriesGrid(),
                  SizedBox(height: screenHeight * 0.03),
                  const BomRfqCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error, size: 40),
        ),
        SizedBox(width: screenWidth * 0.04),
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
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
