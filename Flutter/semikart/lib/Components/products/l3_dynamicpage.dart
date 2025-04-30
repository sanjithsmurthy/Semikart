import 'package:flutter/material.dart';
import '../../services/firestore_services.dart';
import 'l2tile.dart';
import 'l4_tile.dart'; // Import the L4 tile for products

class L3DynamicComponent extends StatelessWidget {
  final String l2CategoryId;

  const L3DynamicComponent({super.key, required this.l2CategoryId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: FirestoreService().fetchL3Categories(l2CategoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No subcategories found.'));
        }

        final l3Items = snapshot.data!;

        return Padding(
          padding: EdgeInsets.all(screenWidth * 0.025), // 10px padding dynamically scaled
          child: ListView.builder(
            itemCount: l3Items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005), // Vertical spacing dynamically scaled (~5px)
                child: Center(
                  child: l2tile(
                    label: l3Items[index]['categoryName'],
                    width: screenWidth * 0.85, // Dynamically scale width (~85% of screen width)
                    onTap: () {
                      // Navigate to the product details or another page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductTileL4(
                            imageUrl: '', // Replace with actual image URL if available
                            productName: l3Items[index]['categoryName'],
                            description: 'Description here', // Replace with actual description
                            category: l3Items[index]['categoryName'],
                            mfrPartNumber: '', // Replace with actual part number
                            manufacturer: '', // Replace with actual manufacturer
                            lifeCycle: '', // Replace with actual lifecycle
                            onViewDetailsPressed: () {
                              // Handle view details action
                            },
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