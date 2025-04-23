import 'package:flutter/material.dart';
import 'l2tile.dart';

class L3DynamicComponent extends StatelessWidget {
  final String l2Category;

  const L3DynamicComponent({super.key, required this.l2Category});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Example L3 items (replace this with API data later)
    final l3Items = [
      '$l2Category - Subcategory 1',
      '$l2Category - Subcategory 2',
      '$l2Category - Subcategory 3',
      '$l2Category - Subcategory 4',
    ];

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.025), // 10px padding dynamically scaled
      child: ListView.builder(
        itemCount: l3Items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005), // Vertical spacing dynamically scaled (~5px)
            child: Center(
              child: l2tile(
                label: l3Items[index],
                width: screenWidth * 0.85, // Dynamically scale width (~85% of screen width)
                onTap: () {
                  // Handle L3 tile tap (e.g., navigate to product details or another page)
                  print('${l3Items[index]} tapped');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}