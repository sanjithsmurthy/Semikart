import 'package:flutter/material.dart';
import '../cart/payment_page.dart'; // Import the PaymentPage (EditPage) widget
import '../cart/payment_progress.dart'; // Import the PaymentProgress widget
import '../cart/payment_failed.dart'; // Import the PaymentFailedScreen widget
import '../cart/cart_page.dart'; // Import the CartPage widget
// import '../common/searchbar_r.dart' as custom; // Import the SearchBar widget with an alias
import '../common/edit_textbox.dart' as edit; // Import the EditTextBox widget with an alias
import '../common/grey_text_box.dart'; // Import the GreyTextBox widget
import '../common/header.dart'; // Import the Header widget
import '../products/products_l1.dart';
import '../products/products_l2.dart'; // Import the ProductsL1Page widget
import '../products/l1_tiles_row.dart'; // Import the Productsonerow widget
import '../products/products_static.dart'; // Import the Productsstaticheader widget

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
            description,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 16),
          // Vendor Part #, Manufacturer, Supplier
          _buildDetailRow("Vendor Part #", vendorPartNumber, fontSize),
          _buildDetailRow("Manufacturer", manufacturer, fontSize),
          _buildDetailRow("Supplier", supplier, fontSize),
          const SizedBox(height: 16),
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
                width: screenWidth * 0.2, // Dynamic width for the text field
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.01),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
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

  Widget _buildDetailRow(String label, String value, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
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
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class TestLayoutSakshi extends StatefulWidget {
  const TestLayoutSakshi({super.key});

  @override
  _TestLayoutSakshiState createState() => _TestLayoutSakshiState();
}

class _TestLayoutSakshiState extends State<TestLayoutSakshi> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController(); // Controller for GreyTextBox
  final List<Map<String, dynamic>> _cartItems = [
    {
      "mfrPartNumber": "12345",
      "customerPartNumber": "54321",
      "description": "This is the description for Item 1",
      "vendorPartNumber": "V12345",
      "manufacturer": "Manufacturer 1",
      "supplier": "Supplier 1",
      "basicUnitPrice": 1000.0,
      "finalUnitPrice": 1200.0,
      "gstPercentage": 18.0,
      "quantity": 2,
    },
    {
      "mfrPartNumber": "67890",
      "customerPartNumber": "09876",
      "description": "This is the description for Item 2",
      "vendorPartNumber": "V67890",
      "manufacturer": "Manufacturer 2",
      "supplier": "Supplier 2",
      "basicUnitPrice": 2000.0,
      "finalUnitPrice": 2400.0,
      "gstPercentage": 18.0,
      "quantity": 1,
    },
  ]; // Sample cart items with detailed information

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  void _navigateToPaymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Header(
          showBackButton: true,
          title: "Components",
          onBackPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0), // Add 10px padding around SearchBar
                        // child: custom.SearchBar(searchController: searchController),
                      ),
                      const edit.EditTextBox(), // Use the EditTextBox widget here
                      const SizedBox(height: 16), // Add spacing between components
                      GreyTextBox(nameController: nameController), // Pass the controller to GreyTextBox
                      const SizedBox(height: 16), // Add spacing before the button

                      // Payment Page Button
                      ElevatedButton(
                        onPressed: _navigateToPaymentPage,
                        child: const Text('Payment Page'),
                      ),
                      const SizedBox(height: 16),

                      // Cart Page Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartPage()),
                          );
                        },
                        child: const Text('Cart Page'),
                      ),
                      const SizedBox(height: 16),

                      ElevatedButton(
                        onPressed: () => PaymentProgress.show(context: context),
                        child: const Text('Progress'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => PaymentFailedDialog.show(context: context),
                        child: const Text('Failed'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProductsL1Page()),
                          );
                        },
                        child: const Text('Products L1'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProductsL2Page()),
                          );
                        },
                        child: const Text('Products L2'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Productsonerow()),
                          );
                        },
                        child: const Text('One Row'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProductsHeaderContent()),
                          );
                        },
                        child: const Text('Products Header'),
                      ),
                      const SizedBox(height: 16), // Add spacing before cart items
                      ListView.builder(
                        shrinkWrap: true, // Ensures the ListView takes only the required space
                        physics: const NeverScrollableScrollPhysics(), // Disable ListView's scrolling
                        itemCount: _cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = _cartItems[index];
                          return CartItem(
                            mfrPartNumber: cartItem["mfrPartNumber"],
                            customerPartNumber: cartItem["customerPartNumber"],
                            description: cartItem["description"],
                            vendorPartNumber: cartItem["vendorPartNumber"],
                            manufacturer: cartItem["manufacturer"],
                            supplier: cartItem["supplier"],
                            basicUnitPrice: cartItem["basicUnitPrice"],
                            finalUnitPrice: cartItem["finalUnitPrice"],
                            gstPercentage: cartItem["gstPercentage"],
                            quantity: cartItem["quantity"],
                            onDelete: () => _removeItem(index),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TestLayoutSakshi(),
   ));
}