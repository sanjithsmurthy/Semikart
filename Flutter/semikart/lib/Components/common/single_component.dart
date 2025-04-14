import 'package:flutter/material.dart';

class CustomSquare extends StatelessWidget {
  final String imagePath;
  final String text;
  final TextStyle? textStyle;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const CustomSquare({
    super.key,
    required this.imagePath,
    required this.text,
    this.textStyle,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;

    // Set fixed aspect ratio for the component
    final boxWidth = screenWidth * 0.4; // 40% of screen width
    final boxHeight = boxWidth * 0.75; // Maintain a 4:3 aspect ratio
    final imageSize = boxWidth * 0.3; // 30% of box width

    return Container(
      width: boxWidth,
      height: boxHeight,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Dynamically scalable image
          Image.network(
            imagePath,
            width: imageSize, // Dynamically set the width
            height: imageSize, // Dynamically set the height
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8), // Distance between image and text
          // Text below the image
          Text(
            text,
            style: textStyle ??
                TextStyle(
                  fontSize: boxWidth * 0.1, // Responsive font size
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Example usage of CustomSquareBox
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text("CustomSquareBox Example")),
      body: Center(
        child: CustomSquare(
          imagePath:
              'public/assets/images/products/Category Icons_Circuit Protection.png', // Correct image path
          text: 'Circuit Protection',
        ),
      ),
    ),
  ));
}
