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
  ];

  @override
  void initState() {
    super.initState();
    // Update the cart item count based on the number of items
    cartItemCount.value = cartItems.length;
  }
  

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamic font sizes and spacing
    final spacing = screenWidth * 0.02;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: spacing * 0,    // Specify top padding
            bottom: spacing * 2, // Specify bottom padding
            left: spacing * 2,   // Specify left padding
            right: spacing * 2,  // Specify right padding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Share Cart Section
              // ShareCart(
              //   cartName: 'Cart:2025-02-28 15:01:50',
              //   accessId: 'dx5tf0uyxx',
              //   onShare: () {
              //     // Add share functionality
              //   },
              // ),
              // const SizedBox(height: 16),

              // Cart Items Section
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: spacing * 2),
                    child: CartItem(
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
              const SizedBox(height: 16),

              // Grand Total Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spacing * 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Keep this if you want 'Grand Total' left-aligned
                  children: [
                    _buildPriceRow(
                      'Grand Total',
                      '₹ ${_calculateGrandTotal(cartItems).toStringAsFixed(2)}',
                      screenWidth * 0.045,
                      isBold: true,
                    ),
                    const SizedBox(height: 16),
                    // Wrap RedButton with Center widget
                    Center(
                      child: RedButton(
                        label: 'Proceed to Checkout',
                        
                        height: screenWidth * 0.1,
                        onPressed: () {
                          // Navigate to the payment page using the CartNavigator
                          Navigator.of(context).pushNamed('payment'); 
                        },
                         width: screenWidth * 0.55, // You might not need a fixed width when centered
                        fontSize: 16.0, // Custom font size
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

  Widget _buildPriceRow(String label, String value, double fontSize, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

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