import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String mfrPartNumber;
  final String customerPartNumber; // Updated variable name
  final String description;
  final String vendorPartNumber;
  final String manufacturer;
  final String supplier;
  final double basicUnitPrice;
  final double finalUnitPrice;
  final double gstPercentage;
  final int quantity;
  final VoidCallback onDelete;

  const CartItem({
    Key? key,
    required this.mfrPartNumber,
    required this.customerPartNumber, // Updated variable name
    required this.description,
    required this.vendorPartNumber,
    required this.manufacturer,
    required this.supplier,
    required this.basicUnitPrice,
    required this.finalUnitPrice,
    required this.gstPercentage,
    required this.quantity,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Reference screen dimensions
    const double refWidth = 412.0;
    const double refHeight = 917.0;

    // Get current screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate scaling factors
    final widthScale = screenWidth / refWidth;
    final heightScale = screenHeight / refHeight;
    // Use widthScale for horizontal spacing, font sizes, icon sizes, etc.
    // Use heightScale for vertical spacing.
    // Use the smaller scale for general elements like border radius to avoid distortion.
    final scale = widthScale < heightScale ? widthScale : heightScale;

    // Scaled dimensions and font sizes
    final double containerVerticalMargin = 1.0 * heightScale; // ref: 1px
    final double containerPadding = 16.0 * scale; // ref: 16px (using general scale)
    final double borderRadius = 8.0 * scale; // ref: 8px (using general scale)
    final double shadowSpreadRadius = 2.0 * scale;
    final double shadowBlurRadius = 5.0 * scale;
    final double shadowOffsetX = 0.0;
    final double shadowOffsetY = 3.0 * heightScale; // Scale offset vertically

    final double titleFontSize = 16.0 * scale; // ref: 16px
    final double detailFontSize = 14.0 * scale; // ref: 14px
    final double descriptionFontSize = 11.0 * scale; // ref: 11px (made smaller)
    final double iconSize = 24.0 * scale; // ref: 24px

    final double verticalSpacingSmall = 4.0 * heightScale; // ref: 4px
    final double verticalSpacingMedium = 8.0 * heightScale; // ref: 8px
    final double verticalSpacingLarge = 16.0 * heightScale; // ref: 16px

    final double quantityFieldWidth = 60.0 * widthScale; // ref: 60px
    final double quantityFieldHeight = 40.0 * heightScale; // ref: 40px
    final double quantityFieldBorderRadius = 4.0 * scale; // ref: 4px
    final double quantityFieldPadding = 8.0 * scale; // ref: 8px

    final totalPrice = finalUnitPrice * quantity;
    final gstAmount = totalPrice * (gstPercentage / 100);
    final grandTotal = totalPrice + gstAmount;

    return Container(
      margin: EdgeInsets.symmetric(vertical: containerVerticalMargin*0.7), // Dynamic margin
      padding: EdgeInsets.only(bottom:containerPadding, top:0, left:containerPadding, right: containerPadding), // Dynamic padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius), // Dynamic border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: shadowSpreadRadius, // Dynamic spread
            blurRadius: shadowBlurRadius, // Dynamic blur
            offset: Offset(shadowOffsetX, shadowOffsetY), // Dynamic offset
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with Mfr Part # and Delete Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible( // Wrap text in Flexible to prevent overflow
                child: Text(
                  "Mfr Part #: $mfrPartNumber",
                  style: TextStyle(
                    fontSize: titleFontSize, // Dynamic font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis, // Add ellipsis if it overflows
                ),
              ),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete, color: const Color(0xFFA51414), size: iconSize), // Dynamic icon size
                padding: EdgeInsets.zero, // Remove default padding if needed
                constraints: const BoxConstraints(), // Remove default constraints if needed
              ),
            ],
          ),
          SizedBox(height: verticalSpacingMedium), // Dynamic spacing
          // Customer Part Number and Description
          _buildDetailRow("Customer Part Number", customerPartNumber, detailFontSize, heightScale), // Pass scale
          SizedBox(height: verticalSpacingSmall), // Dynamic spacing
          Text(
            description,
            style: TextStyle(
              fontSize: descriptionFontSize, // Dynamic font size
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: verticalSpacingLarge), // Dynamic spacing
          // Vendor Part #, Manufacturer, Supplier
          _buildDetailRow("Vendor Part #", vendorPartNumber, detailFontSize, heightScale), // Pass scale
          _buildDetailRow("Manufacturer", manufacturer, detailFontSize, heightScale), // Pass scale
          _buildDetailRow("Supplier", supplier, detailFontSize, heightScale), // Pass scale
          SizedBox(height: verticalSpacingLarge), // Dynamic spacing
          // Pricing Details
          _buildDetailRow("Basic Unit Price", "₹${basicUnitPrice.toStringAsFixed(2)}", detailFontSize, heightScale), // Pass scale
          _buildDetailRow("Final Unit Price", "₹${finalUnitPrice.toStringAsFixed(2)}", detailFontSize, heightScale), // Pass scale
          SizedBox(height: verticalSpacingLarge), // Dynamic spacing
          // Quantity Input
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Quantity",
                style: TextStyle(
                  fontSize: detailFontSize, // Dynamic font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: quantityFieldWidth, // Dynamic width
                height: quantityFieldHeight, // Dynamic height
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(quantityFieldBorderRadius), // Dynamic radius
                      borderSide: BorderSide(color: Colors.grey.shade400), // Optional: Style border
                    ),
                    enabledBorder: OutlineInputBorder( // Style when enabled
                      borderRadius: BorderRadius.circular(quantityFieldBorderRadius),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder( // Style when focused
                      borderRadius: BorderRadius.circular(quantityFieldBorderRadius),
                      borderSide: const BorderSide(color: Color(0xFFA51414), width: 1.5), // Highlight border
                    ),
                    contentPadding: EdgeInsets.all(quantityFieldPadding), // Dynamic padding
                    isDense: true,
                  ),
                  controller: TextEditingController(text: quantity.toString()),
                  style: TextStyle(fontSize: detailFontSize), // Dynamic font size for input text
                  // Add onChanged or onSubmitted handlers as needed
                ),
              ),
            ],
          ),
          SizedBox(height: verticalSpacingLarge), // Dynamic spacing
          // Total Price, GST, and Grand Total
          _buildDetailRow("Total Price", "₹${totalPrice.toStringAsFixed(2)}", detailFontSize, heightScale), // Pass scale
          _buildDetailRow("GST (${gstPercentage.toStringAsFixed(1)}%)", "₹${gstAmount.toStringAsFixed(2)}", detailFontSize, heightScale), // Pass scale
          _buildDetailRow("Total", "₹${grandTotal.toStringAsFixed(2)}", detailFontSize, heightScale, isTotal: true), // Pass scale and flag
        ],
      ),
    );
  }

  // Helper method to build detail rows with dynamic scaling
  Widget _buildDetailRow(String label, String value, double fontSize, double heightScale, {bool isTotal = false}) {
    final double rowVerticalPadding = 2.0 * heightScale; // ref: 2px

    return Padding(
      padding: EdgeInsets.symmetric(vertical: rowVerticalPadding), // Dynamic padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize, // Use passed dynamic font size
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, // Bold for label only if total
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 8), // Add some fixed space between label and value
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: fontSize, // Use passed dynamic font size
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, // Bold for value only if total
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}