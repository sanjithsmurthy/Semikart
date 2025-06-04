import 'package:flutter/material.dart';

import '../common/red_button.dart'; // Import the RedButton

class ProductTileL4 extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String description;
  final String category;
  final String mfrPartNumber;
  final String manufacturer;
  final String lifeCycle;
  final VoidCallback onViewDetailsPressed;

  const ProductTileL4({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.description,
    required this.category,
    required this.mfrPartNumber,
    required this.manufacturer,
    required this.lifeCycle,
    required this.onViewDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Reference screen dimensions
    const double refScreenWidth = 412.0;
    const double refScreenHeight = 917.0;

    // Get current screen dimensions
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Calculate scaling factors
    final double widthScale = screenWidth / refScreenWidth;
    final double heightScale = screenHeight / refScreenHeight;
    final double scale = widthScale < heightScale ? widthScale : heightScale;

    final double cardPadding = 12.0 * scale;
    final double imageSize = 48.0 * scale;
    final double horizontalSpacing = 10.0 * scale;
    final double verticalSpacing = 6.0 * scale;
    final double sectionSpacing = 12.0 * scale;
    final double borderRadius = 8.0 * scale;

    final double productNameFontSize = 16.0 * scale;
    final double descriptionFontSize = 12.0 * scale;
    final double labelFontSize = 12.0 * scale;
    final double valueFontSize = 12.0 * scale;
    final double buttonFontSize = 12.0 * scale;
    final double buttonHeight = 36.0 * scale;
    final double buttonWidth = 120.0 * scale;

    const Color primaryColor = Color(0xFFB71C1C); // Dark Red
    const Color labelColor = Colors.grey;
    const Color valueColor = Colors.black87;

    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0 * scale, vertical: 1.0 * scale),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDEEEE), // Light red/pinkish
              Colors.white,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
          border: Border(
            left: BorderSide(
              color: Color(0xFFA51414),
              width: 4 * scale,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(cardPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image on the left with rounded corners and shadow
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * scale),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10 * scale),
                  child: (imageUrl.isEmpty)
                      ? Container(
                          width: imageSize * 0.95,
                          height: imageSize * 0.95,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.broken_image,
                            size: imageSize * 0.6,
                            color: Colors.grey,
                          ),
                        )
                      : Image.network(
                          imageUrl,
                          width: imageSize * 0.95,
                          height: imageSize * 0.95,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: imageSize * 0.95,
                            height: imageSize * 0.95,
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.broken_image,
                              size: imageSize * 0.6,
                              color: Colors.grey,
                            ),
                          ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              width: imageSize * 0.95,
                              height: imageSize * 0.95,
                              child: Center(
                                child: CircularProgressIndicator(
                                  
                                  color: Color(0xFFA51414),
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  strokeWidth: 2.0 * scale,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
              SizedBox(width: horizontalSpacing * 0.7),
              // Main content (right side)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name and description
                    Text(
                      productName,
                      style: TextStyle(
                        fontSize: productNameFontSize * 0.92,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: verticalSpacing * 0.5),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: descriptionFontSize * 0.92,
                        color: labelColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: sectionSpacing * 0.3),
                    // Two-column details
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow("Category", category, labelFontSize * 0.9, valueFontSize * 0.9, scale * 0.9),
                              SizedBox(height: verticalSpacing * 0.7),
                              _buildDetailRow("Mfr", manufacturer, labelFontSize * 0.9, valueFontSize * 0.9, scale * 0.9),
                            ],
                          ),
                        ),
                        SizedBox(width: horizontalSpacing * 0.5),
                        // Right column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow("Mfr Part #", mfrPartNumber, labelFontSize * 0.9, valueFontSize * 0.9, scale * 0.9),
                              SizedBox(height: verticalSpacing * 0.7),
                              _buildDetailRow("Life Cycle", lifeCycle, labelFontSize * 0.9, valueFontSize * 0.9, scale * 0.9),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: sectionSpacing * 0.5),
                    // View Details button left-aligned
                    RedButton(
                      label: "View Details",
                      onPressed: onViewDetailsPressed,
                      width: buttonWidth * 0.85,
                      height: buttonHeight * 0.8,
                      fontSize: buttonFontSize * 0.9,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for detail rows
  Widget _buildDetailRow(String label, String value, double labelSize, double valueSize, double scale) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70 * scale,
          child: Text(
            label,
            style: TextStyle(
              fontSize: labelSize,
              color: Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: valueSize,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}