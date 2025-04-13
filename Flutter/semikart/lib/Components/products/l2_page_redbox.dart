import 'package:flutter/material.dart';

class RedBorderBox extends StatelessWidget {
  final String text; // Text to display inside the box
  final double widthFactor; // Width factor relative to screen width
  final Color borderColor; // Border color
  final TextStyle? textStyle; // Custom text style
  final EdgeInsetsGeometry? padding; // Padding inside the box

  const RedBorderBox({
    super.key,
    required this.text,
    this.widthFactor = 0.9, // Default width is 90% of screen width
    this.borderColor = const Color(0xFFA51414), // Default border color
    this.textStyle,
    this.padding =
        const EdgeInsets.symmetric(horizontal: 16.0), // Default padding
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        width: screenWidth * widthFactor, // Responsive width
        height: screenHeight * 0.08, // Responsive height (8% of screen height)
        padding: padding, // Apply padding
        decoration: BoxDecoration(
          border: Border.all(
              color: borderColor, width: 1.5), // Border with color and width
          borderRadius:
              BorderRadius.circular(10), // Rounded corners with radius 10
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'Product Sans',
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// Example usage of RedBorderBox
void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: RedBorderBox(
          text: 'Din Rail Mounting Enclosures/Accessories', // Text to display
        ),
      ),
    ),
  ));
}
