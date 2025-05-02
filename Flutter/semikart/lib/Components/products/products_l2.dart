// products_l2.dart - Full working solution
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'l2_page_redbox.dart';

class ProductsL2Page extends StatefulWidget {
  const ProductsL2Page({super.key});

  @override
  State<ProductsL2Page> createState() => _ProductsL2PageState();
}

class _ProductsL2PageState extends State<ProductsL2Page> {
  String? l1CategoryName;

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

    // Debug print to verify docId
    print('L1 Category ID: $docId');

    // Get L1 category name
    _fetchL1CategoryName(docId);

    return Scaffold(
      appBar: AppBar(
        title: Text(l1CategoryName ?? 'L2 Categories'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Query the l2_products collection where l1id matches the docId
        stream: FirebaseFirestore.instance
            .collection('l2_products')
            .where('l1id', isEqualTo: '/l1_products/$docId') // Match the l1id field
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No subcategories found for this category.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _createSampleL2Category(docId),
                    child: const Text('Create Sample Subcategory'),
                  ),
                ],
              ),
            );
          }

          // Map Firestore documents to a list of categories with safe casting
          final l2Categories = snapshot.data!.docs.map((doc) {
            // Debug print to check each document
            print('Document ID: ${doc.id}, Data: ${doc.data()}');

            // Safely cast to Map with null check
            final data = doc.data() as Map<String, dynamic>? ?? {};
            return {
              
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
                        "l1Id": l2Categories[index]["id"],
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

  // Helper method to fetch L1 category name
  void _fetchL1CategoryName(String docId) {
    FirebaseFirestore.instance
        .collection('l1_products')
        .doc(docId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('name')) {
          setState(() {
            l1CategoryName = data['name'] as String?;
          });
        }
      }
    }).catchError((error) {
      print('Error fetching L1 category name: $error');
    });
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