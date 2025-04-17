import 'package:flutter/material.dart';

class Capsule extends StatelessWidget {
  final String label;
  final String imagePath; // Path to the image
  final VoidCallback onTap;

  const Capsule({
    super.key,
    required this.label,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamically calculate the image size (base size is 20x20)
    final imageSize = screenWidth * 0.05; // 5% of screen width, scalable (~20px)

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.8, // Dynamically scalable width (~182.5px)
        height: screenWidth * 0.125, // Decreased height to half (~12px dynamically scalable)
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50), // Capsule shape
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.04), // Add 15px dynamically scalable padding to the left
              child: Image.asset(
                imagePath, // Load the image using Image.asset
                width: imageSize, // Dynamically scalable width (~20px)
                height: imageSize, // Dynamically scalable height (~20px)
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: Colors.red); // Fallback if the image fails to load
                },
              ),
            ),
            SizedBox(width: screenWidth * 0.04), // Add 15px dynamically scalable gap between icon and text
            Expanded( // Wrap the Text widget with Expanded
              child: Text(
                label,
                style: TextStyle(
                  fontSize: screenWidth * 0.025, // Dynamically scalable font size (~14px)
                  
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
              ),
            ),
          ],
        ),
      ),
    );
  }
}