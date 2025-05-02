// products_l2.dart - Full working solution
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'l2_tile.dart';

class ProductsL2Page extends StatefulWidget {
  const ProductsL2Page({super.key});

  @override
  State<ProductsL2Page> createState() => _ProductsL2PageState();
}

class _ProductsL2PageState extends State<ProductsL2Page> {
  Future<String?> _getL1DocIdFromName(String name) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('l1_products')
        .where('name', isEqualTo: name)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Safely retrieve the arguments passed from the L1 page
    final Object? routeArgs = ModalRoute.of(context)?.settings.arguments;

    if (routeArgs == null) {
      // Return error widget directly, without Scaffold
      return const Center(child: Text('No category information provided'));
    }

    final Map<String, dynamic> args = routeArgs as Map<String, dynamic>;
    final String? l1Name = args["l1Name"] as String?;

    if (l1Name == null || l1Name.isEmpty) {
      // Return error widget directly, without Scaffold
       return const Center(child: Text('Invalid L1 category name provided'));
    }

    print('L1 Category Name received: $l1Name'); // Debug print

    // Return the FutureBuilder directly, removing the Scaffold and AppBar
    return FutureBuilder<String?>(
      future: _getL1DocIdFromName(l1Name),
      builder: (context, idSnapshot) {
        if (idSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (idSnapshot.hasError || !idSnapshot.hasData || idSnapshot.data == null) {
          return Center(
            child: Text('Error finding L1 category ID for name: "$l1Name"'),
          );
        }

        final String fetchedDocId = idSnapshot.data!;
        print('Fetched L1 Document ID: $fetchedDocId'); // Debug print

        // Now use the fetchedDocId in the StreamBuilder for L2 products
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('l2_products')
              .where('l1id', isEqualTo: FirebaseFirestore.instance.doc('/l1_products/$fetchedDocId'))
              .snapshots(),
          builder: (context, l2Snapshot) {
            if (l2Snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (l2Snapshot.hasError) {
              return Center(child: Text('Error fetching L2 products: ${l2Snapshot.error}'));
            }

            if (!l2Snapshot.hasData || l2Snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      'No subcategories found for "$l1Name".',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _createSampleL2Category(fetchedDocId),
                      child: const Text('Create Sample Subcategory'),
                    ),
                  ],
                ),
              );
            }

            final l2Categories = l2Snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>? ?? {};
              return {
                "id": doc.id,
                "name": data["name"] as String? ?? "Unknown",
              };
            }).toList();

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: l2Categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        'l3',
                        arguments: {
                          "l2Id": l2Categories[index]["id"],
                        },
                      );
                    },
                    child: RedBorderBox(text: l2Categories[index]["name"] as String),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  // Helper method to create a sample L2 category for testing
  Future<void> _createSampleL2Category(String l1Id) async {
    try {
      await FirebaseFirestore.instance.collection('l2_products').add({
        'name': 'Sample Subcategory (${DateTime.now().toString().substring(0, 19)})',
        'l1id': '/l1_products/$l1Id',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sample subcategory created!')),
      );
    } catch (e) {
      print('Error creating sample category: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}