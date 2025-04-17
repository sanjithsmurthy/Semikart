import 'package:flutter/material.dart' hide SearchBar; // Hide default SearchBar
import '../common/search_bar.dart'; // Use the custom SearchBar from search_bar.dart

class ProductSearch extends StatelessWidget {
  const ProductSearch({super.key});

  @override
  Widget build(BuildContext context) {
    // No need to get screen height here if we let the layout adapt naturally
    // final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Define padding based on screen width
    final horizontalPadding = screenWidth * 0.05; // 5% padding on each side
    final verticalPadding = 20.0; // Fixed vertical padding

    // Return a Column for simpler vertical layout, within Padding
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Column(
        // Make the column take up available vertical space but not more
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchBar(
            // hintText: 'Search for products...', // Add hint text if desired
            // borderRadius: screenWidth * 0.05, // Adjust border radius if needed
          ),
          const SizedBox(height: 20), // Space between search bar and results
          // Expanded( // Use Expanded if you want results to fill remaining space
          //   child: Container(
          //     // Placeholder for search results
          //     color: Colors.grey.shade100,
          //     child: const Center(child: Text('Search Results Area')),
          //   ),
          // ),
        ],
      ),
    );
  }
}