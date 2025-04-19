import 'package:flutter/material.dart';
import 'search_failed.dart'; // Import the SearchFailed widget

class SearchBar extends StatefulWidget {
  final String hintText;
  final Color backgroundColor;
  final Color iconColor;
  final double borderRadius;
  final ValueChanged<String>? onChanged; // Optional onChanged callback

  const SearchBar({
    super.key,
    this.hintText = 'Search', // Default hint text
    this.backgroundColor = const Color(0xFFE4E8EC), // Default grey background
    this.iconColor = const Color(0xFFA51414), // Default red icon color
    this.borderRadius = 20.0, // Default border radius
    this.onChanged, // Optional onChanged callback
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showSuggestions = false;

  // Example categorized suggestions
  final List<String> _manufacturerResults = [
    'Bomar Interconnect',
    'Electronic Assembly',
    'Electro Switch',
  ];
  final List<String> _categoryResults = [
    'Connectors',
    'Cables',
    'Switches',
  ];
  final List<String> _partNumberResults = [
    'BOM06501',
    'BOM06714',
    'BOM10045',
  ];

  List<String> _filteredManufacturerResults = [];
  List<String> _filteredCategoryResults = [];
  List<String> _filteredPartNumberResults = [];

  void _onTextChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _showSuggestions = false;
        _filteredManufacturerResults = [];
        _filteredCategoryResults = [];
        _filteredPartNumberResults = [];
      } else {
        _showSuggestions = true;
        _filteredManufacturerResults = _manufacturerResults
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
        _filteredCategoryResults = _categoryResults
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
        _filteredPartNumberResults = _partNumberResults
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }

      // Call the onChanged callback if provided
      if (widget.onChanged != null) {
        widget.onChanged!(query);
      }
    });
  }

  void _onSuggestionSelected(String suggestion) {
    setState(() {
      _controller.text = suggestion;
      _showSuggestions = false;

      // Call the onChanged callback with the selected suggestion
      if (widget.onChanged != null) {
        widget.onChanged!(suggestion);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Bar
        Container(
          width: screenWidth * 0.9, // Scale width to 90% of screen width
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: widget.backgroundColor, // Background color
            borderRadius: BorderRadius.circular(widget.borderRadius), // Rounded corners
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onChanged: _onTextChanged,
                ),
              ),
              Icon(
                Icons.search,
                color: widget.iconColor, // Customizable icon color
              ),
            ],
          ),
        ),
        // Suggestions Overlay or SearchFailed
        if (_showSuggestions)
          Container(
            width: screenWidth * 0.9,
            margin: const EdgeInsets.only(top: 40.0), // Increased top margin for spacing
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: _filteredManufacturerResults.isEmpty &&
                    _filteredCategoryResults.isEmpty &&
                    _filteredPartNumberResults.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 16.0), // Add top padding for SearchFailed
                    child: const SearchFailed(), // Show SearchFailed if no results
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Manufacturer Results
                      if (_filteredManufacturerResults.isNotEmpty) ...[
                        Text(
                          'Manufacturer Results',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: widget.iconColor,
                          ),
                        ),
                        Divider(color: Colors.grey),
                        ..._filteredManufacturerResults.map((result) {
                          return ListTile(
                            title: Text(result),
                            onTap: () => _onSuggestionSelected(result),
                          );
                        }).toList(),
                      ],
                      // Category Results
                      if (_filteredCategoryResults.isNotEmpty) ...[
                        SizedBox(height: 8),
                        Text(
                          'Category Results',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: widget.iconColor,
                          ),
                        ),
                        Divider(color: Colors.grey),
                        ..._filteredCategoryResults.map((result) {
                          return ListTile(
                            title: Text(result),
                            onTap: () => _onSuggestionSelected(result),
                          );
                        }).toList(),
                      ],
                      // Part Number Results
                      if (_filteredPartNumberResults.isNotEmpty) ...[
                        SizedBox(height: 8),
                        Text(
                          'Part Number Results',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: widget.iconColor,
                          ),
                        ),
                        Divider(color: Colors.grey),
                        ..._filteredPartNumberResults.map((result) {
                          return ListTile(
                            title: Text(result),
                            onTap: () => _onSuggestionSelected(result),
                          );
                        }).toList(),
                      ],
                    ],
                  ),
          ),
      ],
    );
  }
}