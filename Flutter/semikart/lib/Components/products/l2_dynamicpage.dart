import 'package:flutter/material.dart';
import 'l2tile.dart';
import 'l3_dynamicpage.dart'; // Import the L3DynamicComponent

class L2DynamicComponent extends StatelessWidget {
  final List<String> items;

  const L2DynamicComponent({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.025), // 10px padding dynamically scaled
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005), // Vertical spacing dynamically scaled (~5px)
            child: Center(
              child: l2tile(
                label: items[index],
                width: screenWidth * 0.85, // Dynamically scale width (~85% of screen width)
                onTap: () {
                  // Navigate to the L3DynamicComponent with the selected L2 category
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => L3DynamicComponent(
                        l2Category: items[index], // Pass the selected L2 category
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}