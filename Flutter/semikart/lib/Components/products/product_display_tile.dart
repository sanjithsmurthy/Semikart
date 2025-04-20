import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDisplayTile extends StatelessWidget {
  final String manufacturerPartNumber;
  final String? manufacturerLogoUrl; // Can be null if no logo
  final String? productImageUrl;     // Can be null to show placeholder
  final String productName;
  final String category;
  final String manufacturer;
  final String lifeCycle;
  final String hsnCode;
  final VoidCallback? onCategoryTap; // Optional callback for category chip

  const ProductDisplayTile({
    super.key,
    required this.manufacturerPartNumber,
    this.manufacturerLogoUrl,
    this.productImageUrl,
    required this.productName,
    required this.category,
    required this.manufacturer,
    required this.lifeCycle,
    required this.hsnCode,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;

    // Use a fraction of screen width for responsive padding/margins
    final horizontalPadding = screenSize.width * 0.04;
    final verticalPadding = screenSize.height * 0.02;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding / 2, vertical: verticalPadding / 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
      elevation: 1.0,
      clipBehavior: Clip.antiAlias, // Ensures content respects card boundaries
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Takes minimum vertical space needed
          children: [
            // --- Top Section: Part Number & Logo ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    manufacturerPartNumber,
                    style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (manufacturerLogoUrl != null && manufacturerLogoUrl!.isNotEmpty)
                  SizedBox(
                    height: 30, // Adjust height as needed
                    child: CachedNetworkImage(
                      imageUrl: manufacturerLogoUrl!,
                      placeholder: (context, url) => const SizedBox(width: 50, height: 30), // Simple placeholder
                      errorWidget: (context, url, error) => const Icon(Icons.business, size: 30, color: Colors.grey), // Error icon
                      fit: BoxFit.contain,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12.0),

            // --- Product Image Section ---
            Center( // Center the image area
              child: AspectRatio(
                aspectRatio: 1.5, // Adjust aspect ratio if needed, original looks taller than wide
                child: Container(
                  padding: const EdgeInsets.all(8.0), // Padding around the image/placeholder
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: productImageUrl != null && productImageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: productImageUrl!,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2.0)),
                          errorWidget: (context, url, error) => _buildImagePlaceholder(context),
                          fit: BoxFit.contain, // Use contain to see the whole image
                        )
                      : _buildImagePlaceholder(context),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // --- Product Details Section ---
            Text(
              productName,
              style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              maxLines: 2, // Allow up to two lines for product name
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16.0),

            // Category Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Category',
                  style: textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                ),
                const SizedBox(width: 16.0),
                InkWell( // Make chip tappable
                  onTap: onCategoryTap,
                  borderRadius: BorderRadius.circular(16.0),
                  child: Chip(
                    label: Text(category),
                    labelStyle: TextStyle(
                      color: colorScheme.error, // Red text
                      fontSize: textTheme.labelSmall?.fontSize, // Smaller font for chip
                    ),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: colorScheme.error, width: 1.0), // Red border
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0), // Adjust padding
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // Other Details
            _buildDetailRow(context, 'Mfr Part #', manufacturerPartNumber),
            _buildDetailRow(context, 'Mfr', manufacturer, isHighlight: true, highlightColor: colorScheme.error),
            _buildDetailRow(context, 'Life Cycle', lifeCycle),
            _buildDetailRow(context, 'HSN Code', hsnCode),
          ],
        ),
      ),
    );
  }

  // Helper widget for the placeholder image content
  Widget _buildImagePlaceholder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.broken_image_outlined, size: 50, color: Colors.grey[400]), // Placeholder icon
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "There's no image here, yet.",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // Helper widget for detail rows (Label: Value)
  Widget _buildDetailRow(BuildContext context, String label, String value, {bool isHighlight = false, Color? highlightColor}) {
    final textTheme = Theme.of(context).textTheme;
    // Calculate label width dynamically based on screen size or use a reasonable fixed width
    final labelWidth = MediaQuery.of(context).size.width * 0.22; // Adjust multiplier as needed

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0), // Reduced vertical padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: labelWidth, // Dynamic width for labels
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12.0), // Slightly reduced space
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: isHighlight ? highlightColor : textTheme.bodyLarge?.color, // Use default text color if not highlighted
              ),
            ),
          ),
        ],
      ),
    );
  }
}