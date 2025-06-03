import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final String hintText;
  final Color backgroundColor;
  final Color iconColor;
  final double borderRadius;
  final ValueChanged<String>? onChanged;

  const SearchBar({
    super.key,
    this.hintText = 'Search',
    this.backgroundColor = const Color(0xFFE4E8EC),
    this.iconColor = const Color(0xFFA51414),
    this.borderRadius = 20.0,
    this.onChanged,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _onTextChanged(String query) {
    if (widget.onChanged != null) {
      widget.onChanged!(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsive scaling
    const double refScreenWidth = 412.0;
    const double refScreenHeight = 917.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double widthScale = screenWidth / refScreenWidth;
    final double heightScale = screenHeight / refScreenHeight;
    final double fontScale = widthScale < heightScale ? widthScale : heightScale;
    double scaleW(double value) => value * widthScale;
    double scaleH(double value) => value * heightScale;
    double scaleF(double value) => value * fontScale;

    return Container(
      width: screenWidth * 0.9,
      padding: EdgeInsets.symmetric(horizontal: scaleW(16.0)),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(scaleF(widget.borderRadius)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              cursorColor: Colors.black,
              style: TextStyle(fontSize: scaleF(16)),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: scaleF(16),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: scaleH(10.0)),
              ),
              onChanged: _onTextChanged,
            ),
          ),
          Icon(
            Icons.search,
            color: widget.iconColor,
            size: scaleF(24.0),
          ),
        ],
      ),
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