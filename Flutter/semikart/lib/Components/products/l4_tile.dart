import 'package:flutter/material.dart';
import '../../services/firestore_services.dart';
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
    // Use the smaller scale factor to maintain aspect ratio and fit content
    final double scale = widthScale < heightScale ? widthScale : heightScale;    // Scaled dimensions and font sizes - REDUCED for compact layout
    final double cardPadding = 12.0 * scale; // Reduced from 16.0
    final double imageSize = 48.0 * scale; // Reduced from 60.0
    final double horizontalSpacing = 10.0 * scale; // Reduced from 12.0
    final double verticalSpacing = 6.0 * scale; // Reduced from 8.0
    final double sectionSpacing = 12.0 * scale; // Reduced from 16.0
    final double borderRadius = 8.0 * scale;

    final double productNameFontSize = 16.0 * scale; // Reduced from 18.0
    final double descriptionFontSize = 12.0 * scale; // Reduced from 13.0
    final double labelFontSize = 12.0 * scale; // Reduced from 14.0
    final double valueFontSize = 12.0 * scale; // Reduced from 14.0
    final double buttonFontSize = 12.0 * scale; // Reduced from 14.0
    final double buttonHeight = 36.0 * scale; // Reduced from 40.0
    final double buttonWidth = 120.0 * scale; // Reduced from 130.0

    const Color primaryColor = Color(0xFFB71C1C); // Dark Red (adjust if needed)
    const Color labelColor = Colors.grey;
    const Color valueColor = Colors.black87;    return Card(
      color: Colors.white, // Set background to white
      elevation: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0 * scale, vertical: 1.0 * scale), // Changed from EdgeInsets.all(8.0 * scale)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Reduce vertical height
          children: [
            // Top Section: Image, Name, Description
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Image.network(
                  imageUrl,
                  width: imageSize * 0.85, // Reduce image size further
                  height: imageSize * 0.85,
                  fit: BoxFit.contain,
                  // Optional: Add error handling for image loading
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.broken_image,
                    size: imageSize * 0.85,
                    color: labelColor,
                  ),
                  // Optional: Add a loading indicator
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: imageSize * 0.85,
                      height: imageSize * 0.85,
                      child: Center(
                        child: CircularProgressIndicator(
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
                SizedBox(width: horizontalSpacing * 0.3), // Reduce spacing
                // Name and Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(
                          fontSize: productNameFontSize * 0.92, // Reduce font size
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: verticalSpacing / 2 * 0.7),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: descriptionFontSize * 0.92, // Reduce font size
                          color: labelColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: sectionSpacing * 0.3), // Reduce spacing

            // Middle Section: Details
            _buildDetailRow("Category", category, labelFontSize * 0.9, valueFontSize * 0.9, scale * 0.9),
            SizedBox(height: verticalSpacing * 0.7),
            _buildDetailRow("Mfr Part #", mfrPartNumber, labelFontSize * 0.9, valueFontSize * 0.9, scale * 0.9),
            SizedBox(height: verticalSpacing * 0.7),
            _buildDetailRow("Mfr", manufacturer, labelFontSize * 0.9, valueFontSize * 0.9, scale * 0.9),
            SizedBox(height: verticalSpacing * 0.7),
            _buildDetailRow("Life Cycle", lifeCycle, labelFontSize * 0.9, valueFontSize * 0.9, scale * 0.9),

            SizedBox(height: sectionSpacing * 0.7),

            // Bottom Section: Button
            Align(
              alignment: Alignment.centerRight,
              child: RedButton(
                label: "View Details",
                onPressed: onViewDetailsPressed,
                width: buttonWidth * 0.85, // Reduce button width
                height: buttonHeight * 0.8, // Reduce button height
                fontSize: buttonFontSize * 0.9, // Reduce button font size
              ),
            ),
          ],
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
          width: 80 * scale, // Reduce label width
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
        // SizedBox(width: 5 * scale), // Reduce spacing
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