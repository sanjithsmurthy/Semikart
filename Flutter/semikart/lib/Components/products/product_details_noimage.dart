import 'package:flutter/material.dart';

class ProductDetailsNoImage extends StatelessWidget {
  final String manufacturerPartNumber;
  final String manufacturerImagePath;
  final String eatonImagePath;

  const ProductDetailsNoImage({
    Key? key,
    required this.manufacturerPartNumber,
    required this.manufacturerImagePath,
    required this.eatonImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive dimensions
    final containerWidth = screenWidth * 0.9; // 90% of screen width
    final containerHeight = screenHeight * 0.5; // 50% of screen height

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.zero, // Set corner radius to 0
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Manufacturer Part Number (Top-Left Corner)
          Padding(
            padding: EdgeInsets.only(
              top: containerHeight * 0.03, // 3% of container height
              left: containerWidth * 0.03, // 3% of container width
            ),
            child: Text(
              manufacturerPartNumber,
              style: TextStyle(
                fontSize: containerWidth * 0.04, // Responsive font size
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
              height: containerHeight * 0.02), // Add spacing between elements
          // Eaton Image
          Padding(
            padding: EdgeInsets.only(left: containerWidth * 0.03),
            child: SizedBox(
              width: containerWidth * 0.2, // 20% of container width
              height: containerHeight * 0.1, // 10% of container height
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.network(
                    eatonImagePath), // Use Image.asset for local images
              ),
            ),
          ),
          SizedBox(
              height: containerHeight * 0.05), // Add spacing between elements
          // Manufacturer Image
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: containerWidth * 0.09, // 9% of container width
              ),
              child: Image.network(
                manufacturerImagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'Image not found',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
