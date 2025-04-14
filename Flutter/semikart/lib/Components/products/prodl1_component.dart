import 'package:flutter/material.dart';

class CustomSquareBox extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;
  final String text;
  final double imageSize;
  final TextStyle? textStyle;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const CustomSquareBox({
    super.key,
    this.width = 146,
    this.height = 113,
    required this.imagePath,
    required this.text,
    this.imageSize = 40, // Default size for the image
    this.textStyle,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
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
          Image.asset(
            imagePath,
            width: 40, // Explicitly set the width to 40
            height: 40, // Explicitly set the height to 40
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: textStyle ??
                const TextStyle(
                  fontSize: 14,
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
        child: CustomSquareBox(
          imagePath: 'public/assets/icon/circuit_protection.ico', // Correct image path
          text: 'Circuit Protection',
        ),
      ),
    ),
  ));
}
