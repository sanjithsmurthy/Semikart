import 'package:flutter/material.dart';
import 'search_failed.dart'; // Import the SearchFailed widget

class SearchBar extends StatefulWidget {
  final String hintText;
  final Color backgroundColor;
  final Color iconColor;
  final double borderRadius; // Keep this as a base value
  final ValueChanged<String>? onChanged; // Optional onChanged callback

  const SearchBar({
    super.key,
    this.hintText = 'Search', // Default hint text
    this.backgroundColor = const Color(0xFFE4E8EC), // Default grey background
    this.iconColor = const Color(0xFFA51414), // Default red icon color
    this.borderRadius = 20.0, // Base border radius
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
      // Hide keyboard
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    // --- Responsive Scaling Setup ---
    const double refScreenWidth = 412.0;
    const double refScreenHeight = 917.0;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Scaling factors
    final double widthScale = screenWidth / refScreenWidth;
    final double heightScale = screenHeight / refScreenHeight;
    // Use the smaller scale factor for font sizes and radii to avoid excessive growth on large screens
    final double fontScale = widthScale < heightScale ? widthScale : heightScale;

    // Helper function for scaling width-related values
    double scaleW(double value) => value * widthScale;

    // Helper function for scaling height-related values
    double scaleH(double value) => value * heightScale;

    // Helper function for scaling font sizes and radii
    double scaleF(double value) => value * fontScale;
    // --- End Responsive Scaling Setup ---


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Bar
        Container(
          width: screenWidth * 0.9, // Keep relative width
          padding: EdgeInsets.symmetric(horizontal: scaleW(16.0)), // Scaled padding
          decoration: BoxDecoration(
            color: widget.backgroundColor, // Background color
            borderRadius: BorderRadius.circular(scaleF(widget.borderRadius)), // Scaled border radius
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  cursorColor: Colors.black,
                  style: TextStyle(fontSize: scaleF(16)), // Scaled font size
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: scaleF(16), // Scaled hint font size
                    ),
                    border: InputBorder.none,
                    // Adjust content padding if needed for text alignment
                    contentPadding: EdgeInsets.symmetric(vertical: scaleH(10.0)),
                  ),
                  onChanged: _onTextChanged,
                ),
              ),
              Icon(
                Icons.search,
                color: widget.iconColor, // Customizable icon color
                size: scaleF(24.0), // Scaled icon size
              ),
            ],
          ),
        ),
        // Suggestions Overlay or SearchFailed
        if (_showSuggestions)
          Container(
            width: screenWidth * 0.9, // Keep relative width
            margin: EdgeInsets.only(top: scaleH(8.0)), // Reduced and scaled top margin
            padding: EdgeInsets.all(scaleW(8.0)), // Scaled padding
            constraints: BoxConstraints(
              maxHeight: screenHeight * 0.4, // Limit suggestion box height
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(scaleF(10)), // Scaled border radius
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: scaleF(4), // Scaled blur radius
                  offset: Offset(0, scaleH(2)), // Scaled offset
                ),
              ],
            ),
            child: _filteredManufacturerResults.isEmpty &&
                    _filteredCategoryResults.isEmpty &&
                    _filteredPartNumberResults.isEmpty
                ? SingleChildScrollView( // Wrap SearchFailed in a scrollable container
                    child: Padding(
                      padding: EdgeInsets.only(top: scaleH(16.0)), // Scaled top padding
                      child: const SearchFailed(), // Show SearchFailed if no results
                    ),
                  )
                : ListView( // Use ListView for scrollability if content exceeds maxHeight
                    padding: EdgeInsets.zero, // Remove default ListView padding
                    shrinkWrap: true, // Make ListView take minimum space
                    children: [
                      // Manufacturer Results
                      if (_filteredManufacturerResults.isNotEmpty) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: scaleH(4.0), horizontal: scaleW(8.0)),
                          child: Text(
                            'Manufacturer Results',
                            style: TextStyle(
                              fontSize: scaleF(14), // Scaled font size
                              fontWeight: FontWeight.bold,
                              color: widget.iconColor,
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey, height: scaleH(1), thickness: scaleH(1)), // Scaled divider
                        ..._filteredManufacturerResults.map((result) {
                          return ListTile(
                            title: Text(result, style: TextStyle(fontSize: scaleF(15))), // Scaled font size
                            contentPadding: EdgeInsets.symmetric(horizontal: scaleW(16.0), vertical: scaleH(0)), // Scaled padding
                            dense: true, // Reduce vertical space
                            onTap: () => _onSuggestionSelected(result),
                          );
                        }).toList(),
                      ],
                      // Category Results
                      if (_filteredCategoryResults.isNotEmpty) ...[
                        SizedBox(height: scaleH(8)), // Scaled spacing
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: scaleH(4.0), horizontal: scaleW(8.0)),
                          child: Text(
                            'Category Results',
                            style: TextStyle(
                              fontSize: scaleF(14), // Scaled font size
                              fontWeight: FontWeight.bold,
                              color: widget.iconColor,
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey, height: scaleH(1), thickness: scaleH(1)), // Scaled divider
                        ..._filteredCategoryResults.map((result) {
                          return ListTile(
                            title: Text(result, style: TextStyle(fontSize: scaleF(15))), // Scaled font size
                            contentPadding: EdgeInsets.symmetric(horizontal: scaleW(16.0), vertical: scaleH(0)), // Scaled padding
                            dense: true,
                            onTap: () => _onSuggestionSelected(result),
                          );
                        }).toList(),
                      ],
                      // Part Number Results
                      if (_filteredPartNumberResults.isNotEmpty) ...[
                        SizedBox(height: scaleH(8)), // Scaled spacing
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: scaleH(4.0), horizontal: scaleW(8.0)),
                          child: Text(
                            'Part Number Results',
                            style: TextStyle(
                              fontSize: scaleF(14), // Scaled font size
                              fontWeight: FontWeight.bold,
                              color: widget.iconColor,
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey, height: scaleH(1), thickness: scaleH(1)), // Scaled divider
                        ..._filteredPartNumberResults.map((result) {
                          return ListTile(
                            title: Text(result, style: TextStyle(fontSize: scaleF(15))), // Scaled font size
                            contentPadding: EdgeInsets.symmetric(horizontal: scaleW(16.0), vertical: scaleH(0)), // Scaled padding
                            dense: true,
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

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false, // Prevent layout adjustment when keyboard appears
        appBar: AppBar(
          title: const Text('Search Example'), // Persistent header
        ),
        body: Stack(
          children: [
            // Background or other content
            Positioned.fill(
              child: Container(
                color: Colors.white, // Background color
              ),
            ),
            // Search Bar
            Positioned(
              top: 16, // Fixed position for the search bar
              left: 16,
              right: 16,
              child: const SearchBar(),
            ),
          ],
        ),
      ),
    ),
  );
}