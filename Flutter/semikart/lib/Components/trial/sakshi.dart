import 'package:flutter/material.dart';
import '../cart/payment_page.dart'; // Import the PaymentPage (EditPage) widget
import '../cart/payment_progress.dart'; // Import the PaymentProgress widget
import '../cart/payment_failed.dart'; // Import the PaymentFailedScreen widget
import '../common/searchbar.dart' as custom; // Import the SearchBar widget with an alias
import '../common/edit_textbox.dart' as edit; // Import the EditTextBox widget with an alias
import '../common/grey_text_box.dart'; // Import the GreyTextBox widget
import '../common/header_withback.dart' as header; // Import the Header and CombinedAppBar widgets with an alias
import '../products/products_l1.dart'; // Import the ProductsL1Page widget
import '../products/l1_tiles_row.dart'; // Import the Productsonerow widget
import '../products/products_static.dart'; // Import the Productsstaticheader widget

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            header.CombinedAppBar(
              title: "GO BACK", // Set the title for the page
              onBackPressed: () {
                // Handle back button press
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
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
                      const SizedBox(height: 16), // Add spacing before the button

                      // Payment Page Button
                      ElevatedButton(
                        onPressed: _navigateToPaymentPage,
                        child: const Text('Payment Page'),
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: Image.network(
                                cartItem["imageUrl"],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.broken_image);
                                },
                              ),
                              title: Text(cartItem["title"]),
                              subtitle: Text(cartItem["description"]),
                              trailing: Text("\$${cartItem["price"]}"),
                            ),
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