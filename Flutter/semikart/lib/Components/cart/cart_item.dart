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
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth * 0.02; // Dynamic spacing
    final fontSize = screenWidth * 0.035; // Dynamic font size
    final titleFontSize = screenWidth * 0.04; // Dynamic title font size

    final totalPrice = finalUnitPrice * quantity;
    final gstAmount = totalPrice * (gstPercentage / 100);
    final grandTotal = totalPrice + gstAmount;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0), // Set top and bottom margin to 1px
      padding: EdgeInsets.all(spacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.02), // Dynamic border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
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
              Text(
                "Mfr Part #: $mfrPartNumber",
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, color: Color(0xFFA51414)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Customer Part Number and Description
          _buildDetailRow("Customer Part Number", customerPartNumber, fontSize), // Updated label and variable
          const SizedBox(height: 4),
          Text(
            description, // Removed maxLines and overflow
            style: TextStyle(
              fontSize: screenWidth * 0.027,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 16), // Keep spacing before this group
          // Vendor Part #, Manufacturer, Supplier - Reduced spacing between these
          _buildDetailRow("Vendor Part #", vendorPartNumber, fontSize),
          // Removed SizedBox between Vendor Part # and Manufacturer
          _buildDetailRow("Manufacturer", manufacturer, fontSize),
          // Removed SizedBox between Manufacturer and Supplier
          _buildDetailRow("Supplier", supplier, fontSize),
          const SizedBox(height: 16), // Keep spacing after this group
          // Pricing Details
          _buildDetailRow("Basic Unit Price", "₹${basicUnitPrice.toStringAsFixed(2)}", fontSize),
          _buildDetailRow("Final Unit Price", "₹${finalUnitPrice.toStringAsFixed(2)}", fontSize),
          const SizedBox(height: 16),
          // Quantity Input
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Quantity",
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.1, // Adjusted width
                height: screenWidth * 0.1, // Adjusted height
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.009),
                    ),
                    contentPadding: EdgeInsets.all(screenWidth*0.01), // Adjusted padding
                    isDense: true, // Make it compact
                  ),
                  controller: TextEditingController(text: quantity.toString()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Total Price, GST, and Grand Total
          _buildDetailRow("Total Price", "₹${totalPrice.toStringAsFixed(2)}", fontSize),
          _buildDetailRow("GST (${gstPercentage.toStringAsFixed(1)}%)", "₹${gstAmount.toStringAsFixed(2)}", fontSize),
          _buildDetailRow("Total", "₹${grandTotal.toStringAsFixed(2)}", fontSize),
        ],
      ),
    );
  }

  // Helper method to build detail rows with reduced vertical padding
  Widget _buildDetailRow(String label, String value, double fontSize) {
    return Padding(
      // Reduced vertical padding from 4.0 to 2.0
      padding: const EdgeInsets.symmetric(vertical: 2.0), // <-- Keep this reduced value
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis, // Keep ellipsis for value if needed
            ),
          ),
        ],
      ),
    );
  }
}