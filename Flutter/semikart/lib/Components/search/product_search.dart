import 'package:flutter/material.dart' hide SearchBar; // Hide default SearchBar
import '../common/search_bar.dart'; // Use the custom SearchBar from search_bar.dart

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  final List<String> _searchResults = []; // Simulate search results (empty initially)
  String _query = ''; // Track the current search query

  void _onSearch(String query) {
    setState(() {
      _query = query;

      // Simulate search logic
      if (query.isNotEmpty && query.toLowerCase() == 'example') {
        _searchResults.clear();
        _searchResults.add('Example Product 1');
        _searchResults.add('Example Product 2');
      } else {
        _searchResults.clear(); // No results for other queries
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.05; // 5% padding on each side
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.03; // 3% of screen height for vertical padding

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          SearchBar(
            hintText: 'Search for products...',
            borderRadius: screenWidth * 0.05,
            onChanged: _onSearch, // Pass the search query to the handler
          ),
            SizedBox(height: screenHeight * 0.02), // Use a percentage of screen height

          // Display Search Results
          Expanded(
            child: _searchResults.isEmpty
                ? Container() // Remove "No results found" text
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_searchResults[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}