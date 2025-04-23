import 'package:flutter/material.dart';
import 'cart_item.dart';
// import 'share_cart.dart';
import '../common/red_button.dart'; // Import RedButton

// Global ValueNotifier to track cart item count
ValueNotifier<int> cartItemCount = ValueNotifier<int>(0);

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Sample cart items data
  final List<Map<String, dynamic>> cartItems = [
    {
      "mfrPartNumber": "LSP4-480",
      "customerPartNumber": "Customer Part",
      "description": "LED Protection Devices\nLED Protection Devices, 120VAC-480VAC, 10kA/20kA, Compact Design",
      "vendorPartNumber": "837-LSP4-480",
      "manufacturer": "Hatch Lighting",
      "supplier": "Mouser Electronics",
      "basicUnitPrice": 911.93,
      "finalUnitPrice": 1103.3441,
      "quantity": 1,
      "gstPercentage": 18.0,
    },
    {
      "mfrPartNumber": "X22223201",
      "customerPartNumber": "Customer Part",
      "description": "Circuit Breaker Accessories Inactive - superseded by X222-232-11 1180 ACC- 12 Pole Cuttable Bus Connection",
      "vendorPartNumber": "E-T-A",
      "manufacturer": "E-T-A",
      "supplier": "Master Electronics",
      "basicUnitPrice": 1987.81,
      "finalUnitPrice": 2581.348,
      "quantity": 5,
      "gstPercentage": 18.0,
    },
    // Add more items as needed
  ];

  @override
  void initState() {
    super.initState();
    // Update the cart item count based on the number of items
    cartItemCount.value = cartItems.length;
  }


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
    // Use the smaller scale for general elements like padding, border radius, font sizes
    final scale = widthScale < heightScale ? widthScale : heightScale;

    // Scaled dimensions and font sizes
    final double pagePadding = 16.0 * scale; // ref: 16px
    final double itemBottomPadding = 16.0 * heightScale; // ref: 16px (vertical spacing)
    final double sectionSpacing = 16.0 * heightScale; // ref: 16px (vertical spacing)
    final double totalSectionPadding = 16.0 * scale; // ref: 16px
    final double borderRadius = 8.0 * scale; // ref: 8px
    final double shadowBlurRadius = 6.0 * scale; // ref: 6px
    final double shadowSpreadRadius = 2.0 * scale; // ref: 2px
    final double grandTotalFontSize = 18.0 * scale; // ref: 18px
    final double buttonHeight = 50.0 * heightScale; // ref: 50px
    final double buttonWidth = 220.0 * widthScale; // ref: 220px
    final double buttonFontSize = 16.0 * scale; // ref: 16px

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(pagePadding), // Use scaled padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Share Cart Section (If you re-enable it, ensure it's also scaled)
              // ShareCart(...)
              // SizedBox(height: sectionSpacing), // Use scaled spacing

              // Cart Items Section
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Padding(
                    // Use specific vertical padding for items
                    padding: EdgeInsets.only(bottom: itemBottomPadding),
                    child: CartItem( // Assuming CartItem handles its own internal scaling
                      mfrPartNumber: item["mfrPartNumber"] as String,
                      customerPartNumber: item["customerPartNumber"] as String,
                      description: item["description"] as String,
                      vendorPartNumber: item["vendorPartNumber"] as String,
                      manufacturer: item["manufacturer"] as String,
                      supplier: item["supplier"] as String,
                      basicUnitPrice: item["basicUnitPrice"] as double,
                      finalUnitPrice: item["finalUnitPrice"] as double,
                      gstPercentage: item["gstPercentage"] as double,
                      quantity: item["quantity"] as int,
                      onDelete: () {
                        setState(() {
                          cartItems.removeAt(index); // Remove the item from the list
                          cartItemCount.value = cartItems.length; // Update the cart item count
                        });
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: sectionSpacing), // Use scaled spacing

              // Grand Total Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(totalSectionPadding), // Use scaled padding
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius), // Use scaled radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: shadowBlurRadius, // Use scaled blur
                      spreadRadius: shadowSpreadRadius, // Use scaled spread
                      offset: Offset(0, 2 * heightScale), // Optional: scale offset vertically
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPriceRow(
                      'Grand Total',
                      '₹ ${_calculateGrandTotal(cartItems).toStringAsFixed(2)}',
                      grandTotalFontSize, // Use scaled font size
                      isBold: true,
                    ),
                    SizedBox(height: sectionSpacing), // Use scaled spacing
                    // Wrap RedButton with Center widget
                    Center(
                      child: RedButton(
                        label: 'Proceed to Checkout',
                        height: buttonHeight, // Use scaled height
                        width: buttonWidth, // Use scaled width
                        fontSize: buttonFontSize, // Use scaled font size
                        onPressed: () {
                          // Navigate to the payment page
                          Navigator.of(context).pushNamed('payment');
                        },
                      ),
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

  // Helper for price rows, now uses passed font size directly
  Widget _buildPriceRow(String label, String value, double fontSize, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize, // Use the passed scaled font size
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize, // Use the passed scaled font size
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // Calculation logic remains the same
  double _calculateGrandTotal(List<Map<String, dynamic>> cartItems) {
    double grandTotal = 0.0;
    for (var item in cartItems) {
      final totalPrice = (item["finalUnitPrice"] as double) * (item["quantity"] as int);
      final gstAmount = totalPrice * ((item["gstPercentage"] as double) / 100);
      grandTotal += totalPrice + gstAmount;
    }
    return grandTotal;
  }
}