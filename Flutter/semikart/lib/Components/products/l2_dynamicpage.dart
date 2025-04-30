import 'package:flutter/material.dart';
import '../../services/firestore_services.dart';
import 'l2tile.dart';
import 'l3_dynamicpage.dart'; // Import the L3DynamicComponent

class L2DynamicComponent extends StatelessWidget {
  final String l1CategoryId;

  const L2DynamicComponent({super.key, required this.l1CategoryId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: FirestoreService().fetchL2Categories(l1CategoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No subcategories found.'));
        }

        final items = snapshot.data!;

        return Padding(
          padding: EdgeInsets.all(screenWidth * 0.025), // 10px padding dynamically scaled
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005), // Vertical spacing dynamically scaled (~5px)
                child: Center(
                  child: l2tile(
                    label: items[index]['categoryName'],
                    width: screenWidth * 0.85, // Dynamically scale width (~85% of screen width)
                    onTap: () {
                      // Navigate to the L3DynamicComponent with the selected L2 category
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => L3DynamicComponent(
                            l2CategoryId: items[index]['categoryId'], // Pass the selected L2 category ID
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
      },
    );
  }
}