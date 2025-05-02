// products_l2.dart - Fixed implementation with null safety
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'l2_page_redbox.dart';

class ProductsL2Page extends StatelessWidget {
  const ProductsL2Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Safely retrieve the arguments passed from the L1 page with null checks
    final Object? routeArgs = ModalRoute.of(context)?.settings.arguments;
    
    // Handle case where no arguments are passed
    if (routeArgs == null) {
      return const Scaffold(
        body: Center(child: Text('No category information provided')),
      );
    }
    
    // Safely cast arguments to Map
    final Map<String, dynamic> args = routeArgs as Map<String, dynamic>;
    
    // Safely retrieve docId with null check
    final String? docId = args["docId"] as String?;
    
    if (docId == null || docId.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Invalid category ID')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subcategories'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Query the l2_products collection where l1id matches the docId
        stream: FirebaseFirestore.instance
            .collection('l2_products')
            .where('l1id', isEqualTo: docId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No subcategories available'));
          }

          // Map Firestore documents to a list of categories with safe casting
          final l2Categories = snapshot.data!.docs.map((doc) {
            // Safely cast to Map with null check
            final data = doc.data() as Map<String, dynamic>? ?? {};
            return {
              "id": doc.id,
              "name": data["name"] as String? ?? "Unknown",
            };
          }).toList();

          // Render the categories in a ListView
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: l2Categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to L3 with the L2 category name
                    Navigator.of(context).pushNamed(
                      'l3',
                      arguments: {
                        "l2Id": l2Categories[index]["id"],
                        "l2Name": l2Categories[index]["name"],
                      },
                    );
                  },
                  child: RedBorderBox(text: l2Categories[index]["name"] as String),
                ),
              );
            },
          );
        },
      ),
    );
  }
}