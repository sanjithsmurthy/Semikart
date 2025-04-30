import 'package:flutter/material.dart';
import '../../services/firestore_services.dart';
import '../common/red_button.dart'; // Import the RedButton

class ProductTileL4 extends StatelessWidget {
  final String productId;

  const ProductTileL4({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: FirestoreService().fetchProductDetails(productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Center(child: Text('Product details not found.'));
        }

        final product = snapshot.data!;

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
        final double scale = widthScale < heightScale ? widthScale : heightScale;

        // Scaled dimensions and font sizes
        final double cardPadding = 16.0 * scale;
        final double imageSize = 60.0 * scale;
        final double horizontalSpacing = 12.0 * scale;
        final double verticalSpacing = 8.0 * scale;
        final double sectionSpacing = 16.0 * scale;
        final double borderRadius = 8.0 * scale;

        final double productNameFontSize = 18.0 * scale;
        final double descriptionFontSize = 13.0 * scale;
        final double labelFontSize = 14.0 * scale;
        final double valueFontSize = 14.0 * scale;
        final double buttonFontSize = 14.0 * scale; // Font size for the button text
        final double buttonHeight = 40.0 * scale; // Specific height for the button
        final double buttonWidth = 130.0 * scale; // Specific width for the button

        const Color primaryColor = Color(0xFFB71C1C); // Dark Red (adjust if needed)
        const Color labelColor = Colors.grey;
        const Color valueColor = Colors.black87;

        return Card(
          elevation: 2.0,
          margin: EdgeInsets.all(8.0 * scale),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Padding(
            padding: EdgeInsets.all(cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Section: Image, Name, Description
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Image.network( // Or Image.asset if local
                      product['imageUrl'] ?? '',
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.contain,
                      // Optional: Add error handling for image loading
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.broken_image,
                        size: imageSize,
                        color: labelColor,
                      ),
                      // Optional: Add a loading indicator
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SizedBox(
                          width: imageSize,
                          height: imageSize,
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
                    SizedBox(width: horizontalSpacing),
                    // Name and Description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'],
                            style: TextStyle(
                              fontSize: productNameFontSize,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: verticalSpacing / 2),
                          Text(
                            product['description'] ?? 'No description available.',
                            style: TextStyle(
                              fontSize: descriptionFontSize,
                              color: labelColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sectionSpacing),

                // Middle Section: Details
                _buildDetailRow("Category", product['categoryName'], labelFontSize, valueFontSize, scale),
                SizedBox(height: verticalSpacing),
                _buildDetailRow("Mfr Part #", product['mfrPartNumber'], labelFontSize, valueFontSize, scale),
                SizedBox(height: verticalSpacing),
                _buildDetailRow("Mfr", product['manufacturer'], labelFontSize, valueFontSize, scale),
                SizedBox(height: verticalSpacing),
                _buildDetailRow("Life Cycle", product['lifeCycle'], labelFontSize, valueFontSize, scale),

                SizedBox(height: sectionSpacing),

                // Bottom Section: Button
                Align(
                  alignment: Alignment.centerRight,
                  child: RedButton( // Use the RedButton component
                    label: "View Details",
                    onPressed: () {
                      // Handle view details action
                    },
                    width: buttonWidth, // Pass calculated width
                    height: buttonHeight, // Pass calculated height
                    fontSize: buttonFontSize, // Pass calculated font size
                    // The RedButton handles its own styling (color, shape)
                    // Ensure isWhiteButton is false (default) for the red style
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper widget for detail rows
  Widget _buildDetailRow(String label, String value, double labelSize, double valueSize, double scale) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100 * scale, // Fixed width for labels for alignment
          child: Text(
            label,
            style: TextStyle(
              fontSize: labelSize,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(width: 8 * scale),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: valueSize,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}