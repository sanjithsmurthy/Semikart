import 'package:flutter/material.dart';
import '../common/payment_page.dart'; // Import the PaymentPage (EditPage) widget
import '../common/payment_progress.dart'; // Import the PaymentProgress widget
import '../common/payment_failed.dart'; // Import the PaymentFailedScreen widget
import '../common/searchbar.dart' as custom; // Import the SearchBar widget with an alias
import '../common/edit_textbox.dart' as edit; // Import the EditTextBox widget with an alias
import '../common/grey_text_box.dart'; // Import the GreyTextBox widgetimport '/Components/cart/cart_item.dart'; // Import the updated MyCartItem widget
import '../common/header_withback.dart' as header; // Import the Header and CombinedAppBar widgets with an alias
import '../common/products_l1.dart'; // Import the ProductsL1Page widget
import '../common/l1_tiles_row.dart'; // Import the Productsonerow widget

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
      "imageUrl": "public/assets/images/products/noImageFound.webp",
      "title": "Item 1",
      "description": "This is the description for Item 1",
      "price": 1000.0,
    },
    {
      "imageUrl": "public/assets/images/products/noImageFound.webp",
      "title": "Item 2",
      "description": "This is the description for Item 2",
      "price": 2000.0,
    },
    {
      "imageUrl": "public/assets/images/products/noImageFound.webp",
      "title": "Item 3",
      "description": "This is the description for Item 3",
      "price": 3000.0,
    },
  ]; // Sample cart items with image, title, description, and price

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
        appBar: AppBar(
          title: const Text('Components'),
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            Expanded(
              child: Scaffold(
                appBar: header.CombinedAppBar(
                  title: "GO BACK", // Set the title for the page
                  onBackPressed: () {
                    // Handle back button press
                    Navigator.pop(context);
                  },
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0), // Add 10px padding around SearchBar
                        child: custom.SearchBar(searchController: searchController),
                      ),
                      const edit.EditTextBox(), // Use the EditTextBox widget here
                      const SizedBox(height: 16), // Add spacing between components
                      GreyTextBox(nameController: nameController), // Pass the controller to GreyTextBox
                      const SizedBox(height: 16), // Add spacing before cart items
                      Expanded(
                        child: ListView.builder(
                          itemCount: _cartItems.length,
                          itemBuilder: (context, index) {
                            final cartItem = _cartItems[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              // child: MyCartItem(
                              //   imageUrl: cartItem["imageUrl"],
                              //   title: cartItem["title"],
                              //   description: cartItem["description"],
                              //   price: cartItem["price"],
                              //   onDelete: () => _removeItem(index),
                              //   onViewDetails: () {
                              //     // Handle view details action
                              //     print("View details for ${cartItem["title"]}");
                              //   },
                              // ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _navigateToPaymentPage,
                  child: const Text('Payment Page'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => PaymentProgress.show(context: context),
                  child: const Text('Progress'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => PaymentFailedDialog.show(context: context),
                  child: const Text('Failed'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProductsL1Page()),
                    );
                  },
                  child: const Text('Products l1'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Productsonerow()),
                    );
                  },
                  child: const Text('one row'),
                ),
              ],
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