import 'package:flutter/material.dart';
import '../Commons/searchbar.dart' as custom; // Import the SearchBar widget with an alias
import '../Commons/grey_text_box.dart'; // Import the GreyTextBox widget
import '../Commons/my_cart.dart'; // Import the updated MyCartItem widget
import '../Commons/edit_textbox.dart'; // Import the EditTextBox widget

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Components'),
          backgroundColor: const Color(0xFFA51414),
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
              const SizedBox(height: 16), // Add spacing between components
              const EditTextBox(), // Add the EditTextBox widget here
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
                      child: MyCartItem(
                        imageUrl: cartItem["imageUrl"],
                        title: cartItem["title"],
                        description: cartItem["description"],
                        price: cartItem["price"],
                        onDelete: () => _removeItem(index),
                        onViewDetails: () {
                          // Handle view details action
                          print("View details for ${cartItem["title"]}");
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const TestLayoutSakshi());
}