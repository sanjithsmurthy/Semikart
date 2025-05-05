// products_l2.dart - Final working solution receiving L1 ID and querying by DocumentReference
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'l2_tile.dart'; // Import the L2Tile widget (which defines RedBorderBox)
import 'products_static.dart'; // Import the static header content

// Remove the local RedBorderBox definition as it's now imported from l2_tile.dart
// class RedBorderBox extends StatelessWidget { ... }

class ProductsL2Page extends StatefulWidget {
  const ProductsL2Page({super.key});

  @override
  State<ProductsL2Page> createState() => _ProductsL2PageState();
}

class _ProductsL2PageState extends State<ProductsL2Page> {
  // Helper method to create a sample L2 category for testing
  // This function is fixed to store l1id as a DocumentReference!
  Future<void> _createSampleL2Category(String l1Id) async {
    try {
      // Get a reference to the L1 document using the passed ID
      final l1DocRef = FirebaseFirestore.instance.collection('l1_products').doc(l1Id);

      await FirebaseFirestore.instance.collection('l2_products').add({
        'name': 'Sample Subcategory (${DateTime.now().toString().substring(0, 16)})', // Shorter timestamp for display
        'l1id': l1DocRef, // *** Store the actual DocumentReference here ***
        // You might want to add other relevant fields here, like description, image, etc.
      });
      if (mounted) { // Check if the widget is still mounted before showing SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sample subcategory created!')),
        );
      }
    } catch (e) {
      print('Error creating sample category: $e');
      if (mounted) { // Check if the widget is still mounted before showing SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating sample subcategory: $e')),
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

    // Padding
    final double dynamicPagePadding = screenWidth * (16 / refWidth); // Approx 16 on ref width
    final double dynamicItemBottomPadding = screenHeight * (16 / refHeight); // Approx 16 on ref height

    // Font Sizes
    final double dynamicErrorFontSize = screenHeight * (16 / refHeight); // Approx 16 on ref height
    final double dynamicButtonFontSize = screenHeight * (14 / refHeight); // Approx 14 on ref height (typical button size)

    // Spacing
    final double dynamicSpacingMedium = screenHeight * (20 / refHeight); // Approx 20 on ref height
    final double dynamicSpacingSmall = screenHeight * (10 / refHeight); // Approx 10 on ref height
    // --- End dynamic scaling ---

    // Safely retrieve the arguments passed from the L1 page
    final Object? routeArgs = ModalRoute.of(context)?.settings.arguments;

    // Validate arguments - expect a Map<String, dynamic>
    if (routeArgs == null || !(routeArgs is Map<String, dynamic>)) {
      // Return simple error widget, no Scaffold
      return Center(child: Text(
        'Navigation Error: No category information provided',
        style: TextStyle(fontSize: dynamicErrorFontSize), // Use dynamic font size
        textAlign: TextAlign.center,
      ));
    }

    final Map<String, dynamic> args = routeArgs;
    // Get the L1 document ID and optional name from arguments
    final String? l1DocId = args["l1DocId"] as String?;
    final String? l1Name = args["l1Name"] as String?; // Optional: used for display text

    // Validate L1 document ID
    if (l1DocId == null || l1DocId.isEmpty) {
       // Return simple error widget, no Scaffold
       return Center(child: Text(
         'Navigation Error: Invalid L1 category ID provided',
         style: TextStyle(fontSize: dynamicErrorFontSize), // Use dynamic font size
         textAlign: TextAlign.center,
       ));
    }

    // *** Get the DocumentReference for the L1 product using the received ID ***
    final l1DocRef = FirebaseFirestore.instance.collection('l1_products').doc(l1DocId);

    // *** Define the query ***
    final query = FirebaseFirestore.instance
        .collection('l2_products')
        .where('l1id', isEqualTo: l1DocRef);

    // Wrap the content in a Column
    return Column(
      children: [
        // Add the fixed header at the top
        const ProductsHeaderContent(),

        // Use Expanded to make the StreamBuilder take remaining space
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: query.snapshots(),
            builder: (context, l2Snapshot) {
              if (l2Snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (l2Snapshot.hasError) {
                return Center(child: Text(
                  'Error fetching L2 products: ${l2Snapshot.error}',
                  style: TextStyle(fontSize: dynamicErrorFontSize),
                  textAlign: TextAlign.center,
                ));
              }

              if (!l2Snapshot.hasData || l2Snapshot.data!.docs.isEmpty) {
                // Display 'No subcategories' message and buttons directly
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Padding(
                         padding: EdgeInsets.all(dynamicPagePadding), // Use dynamic padding
                         child: Text(
                           'No subcategories found for "${l1Name ?? 'this category'}".',
                           style: TextStyle(fontSize: dynamicErrorFontSize), // Use dynamic font size
                           textAlign: TextAlign.center,
                         ),
                       ),
                      SizedBox(height: dynamicSpacingMedium), // Use dynamic spacing
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: dynamicButtonFontSize) // Use dynamic font size
                        ),
                        onPressed: () => _createSampleL2Category(l1DocId),
                        child: const Text('Create Sample Subcategory'),
                      ),
                      SizedBox(height: dynamicSpacingSmall), // Use dynamic spacing
                       ElevatedButton(
                         style: ElevatedButton.styleFrom(
                           textStyle: TextStyle(fontSize: dynamicButtonFontSize) // Use dynamic font size
                         ),
                        onPressed: () {
                           Navigator.of(context).pop();
                        },
                        child: const Text('Go Back'),
                      ),
                    ],
                  ),
                );
              }

              // Process the documents that match the query
              final l2Categories = l2Snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>? ?? {};
                return {
                  "id": doc.id,
                  "name": data["name"] as String? ?? "Unknown",
                };
              }).toList();

              // The ListView is scrollable within the Expanded area
              return ListView.builder(
                padding: EdgeInsets.all(dynamicPagePadding), // Use dynamic padding
                itemCount: l2Categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    // Use dynamic padding for spacing between items
                    padding: EdgeInsets.only(bottom: dynamicItemBottomPadding),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          'l3',
                          arguments: {
                            "l2DocId": l2Categories[index]["id"],
                            "l2Name": l2Categories[index]["name"],
                            "l1DocId": l1DocId,
                            "l1Name": l1Name,
                          },
                        );
                      },
                      // *** Use the imported RedBorderBox widget ***
                      child: RedBorderBox(text: l2Categories[index]["name"] as String),
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