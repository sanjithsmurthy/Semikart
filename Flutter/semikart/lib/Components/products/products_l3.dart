import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import '../products/products_static.dart'; // Import the ProductsHeaderContent widget
import '../products/l2_tile.dart'; // Import the RedBorderBox widget (used as L3Tile)

// Convert to StatefulWidget
class ProductsL3Page extends StatefulWidget {
  const ProductsL3Page({super.key});

  @override
  State<ProductsL3Page> createState() => _ProductsL3PageState();
}

class _ProductsL3PageState extends State<ProductsL3Page> {

  // Optional: Helper method to create a sample L3 category for testing
  Future<void> _createSampleL3Category(String l2Id) async {
    try {
      final l2DocRef = FirebaseFirestore.instance.collection('l2_products').doc(l2Id);
      await FirebaseFirestore.instance.collection('l3_products').add({
        'name': 'Sample L3 Item (${DateTime.now().toString().substring(0, 16)})',
        'l2id': l2DocRef, // Store the L2 DocumentReference
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sample L3 item created!')),
        );
      }
    } catch (e) {
      print('Error creating sample L3 item: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating sample L3 item: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // --- Add dynamic scaling ---
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const double refWidth = 412.0;
    const double refHeight = 917.0;

    final double dynamicPagePadding = screenWidth * (16 / refWidth);
    final double dynamicItemBottomPadding = screenHeight * (16 / refHeight);
    final double dynamicErrorFontSize = screenHeight * (16 / refHeight);
    final double dynamicButtonFontSize = screenHeight * (14 / refHeight);
    final double dynamicSpacingMedium = screenHeight * (20 / refHeight);
    final double dynamicSpacingSmall = screenHeight * (10 / refHeight);
    // --- End dynamic scaling ---

    // Retrieve arguments passed from L2
    final Object? routeArgs = ModalRoute.of(context)?.settings.arguments;

    if (routeArgs == null || !(routeArgs is Map<String, dynamic>)) {
      return Column( // Keep Column structure for header
        children: [
          const ProductsHeaderContent(),
          Expanded(
            child: Center(child: Text(
              'Navigation Error: No L2 category information provided',
              style: TextStyle(fontSize: dynamicErrorFontSize),
              textAlign: TextAlign.center,
            )),
          ),
        ],
      );
    }

    final Map<String, dynamic> args = routeArgs;
    final String? l2DocId = args["l2DocId"] as String?;
    final String? l2Name = args["l2Name"] as String?; // Optional: for display
    // You might also receive l1DocId and l1Name if passed from L2

    if (l2DocId == null || l2DocId.isEmpty) {
       return Column( // Keep Column structure for header
         children: [
           const ProductsHeaderContent(),
           Expanded(
             child: Center(child: Text(
               'Navigation Error: Invalid L2 category ID provided',
               style: TextStyle(fontSize: dynamicErrorFontSize),
               textAlign: TextAlign.center,
             )),
           ),
         ],
       );
    }

    // Create DocumentReference for the L2 product
    final l2DocRef = FirebaseFirestore.instance.collection('l2_products').doc(l2DocId);

    // Define the Firestore query for L3 products
    final query = FirebaseFirestore.instance
        .collection('l3_products')
        .where('l2id', isEqualTo: l2DocRef); // Filter by L2 DocumentReference

    return Column(
      children: [
        // Fixed Header
        const ProductsHeaderContent(),

        // Scrollable List Area
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: query.snapshots(),
            builder: (context, l3Snapshot) {
              if (l3Snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (l3Snapshot.hasError) {
                return Center(child: Text(
                  'Error fetching L3 items: ${l3Snapshot.error}',
                  style: TextStyle(fontSize: dynamicErrorFontSize),
                  textAlign: TextAlign.center,
                ));
              }

              if (!l3Snapshot.hasData || l3Snapshot.data!.docs.isEmpty) {
                // Display 'No items' message and buttons
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Padding(
                         padding: EdgeInsets.all(dynamicPagePadding),
                         child: Text(
                           'No items found for "${l2Name ?? 'this category'}".',
                           style: TextStyle(fontSize: dynamicErrorFontSize),
                           textAlign: TextAlign.center,
                         ),
                       ),
                      SizedBox(height: dynamicSpacingMedium),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: dynamicButtonFontSize)
                        ),
                        onPressed: () => _createSampleL3Category(l2DocId), // Use L2 ID
                        child: const Text('Create Sample L3 Item'),
                      ),
                      SizedBox(height: dynamicSpacingSmall),
                       ElevatedButton(
                         style: ElevatedButton.styleFrom(
                           textStyle: TextStyle(fontSize: dynamicButtonFontSize)
                         ),
                        onPressed: () {
                           Navigator.of(context).pop(); // Go back to L2
                        },
                        child: const Text('Go Back'),
                      ),
                    ],
                  ),
                );
              }

              // Map Firestore documents to a list
              final l3Items = l3Snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>? ?? {};
                return {
                  "id": doc.id, // L3 document ID
                  "name": data["name"] as String? ?? "Unknown", // L3 item name
                };
              }).toList();

              // Display the list using ListView.builder and RedBorderBox
              return ListView.builder(
                padding: EdgeInsets.all(dynamicPagePadding),
                itemCount: l3Items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: dynamicItemBottomPadding),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to L4, passing necessary IDs
                        Navigator.of(context).pushNamed(
                          'l4',
                          arguments: {
                            "l3DocId": l3Items[index]["id"],
                            "l3Name": l3Items[index]["name"],
                            "l2DocId": l2DocId, // Pass down L2 ID
                            "l2Name": l2Name, // Pass down L2 Name
                            // Pass down L1 info if available and needed
                          },
                        );
                        print('L3 Item tapped: ${l3Items[index]["name"]}');
                      },
                      // Use RedBorderBox (imported from l2_tile) for display
                      child: RedBorderBox(text: l3Items[index]["name"] as String),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}