import 'package:flutter/material.dart';

class L1Tile extends StatelessWidget {
  final String iconPath;
  final String text;

  const L1Tile({
    super.key,
    required this.iconPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic scaling based on reference size (412x917) and image proportions (approx 146x113)
    const double refWidth = 412.0;
    const double refHeight = 917.0;
    const double refIconContainerWidth = 135.0;
    const double refIconContainerHeight = 85.0;
    const double refIconSize = 45.0; // Estimated icon size within the container
    const double refFontSize = 16.0; // Estimated font size
    const double refSpacing = 8.0; // Estimated spacing between icon and text

    // Calculate dynamic sizes
    final double dynamicIconContainerWidth = screenWidth * (refIconContainerWidth / refWidth);
    final double dynamicIconContainerHeight = screenHeight * (refIconContainerHeight / refHeight);
    final double dynamicIconSize = screenWidth * (refIconSize / refWidth); // Scale icon with width
    final double dynamicFontSize = screenHeight * (refFontSize / refHeight); // Scale font with height
    final double dynamicSpacing = screenHeight * (refSpacing / refHeight); // Scale spacing with height

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
        mainAxisSize: MainAxisSize.min, // Take minimum space needed
        children: [
          Image.network(
            iconPath.isNotEmpty ? iconPath : 'https://via.placeholder.com/150', // Placeholder image
            width: dynamicIconSize*0.85,
            height: dynamicIconSize*0.85,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.broken_image,
                size: dynamicIconSize,
                color: Colors.grey,
              );
            },
          ),
          SizedBox(height: dynamicSpacing*0.6), // Dynamic spacing
          Text(
            text,
            style: TextStyle(
              fontSize: dynamicFontSize*0.96, // Dynamic font size
              fontWeight: FontWeight.w500, // Match image weight (medium)
              color: Colors.black, // Match image color
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}