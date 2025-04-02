import 'package:flutter/material.dart';
import '../Commons/searchbar.dart' as custom; // Import the SearchBar widget with an alias
import '../Commons/edit_textbox.dart' as edit; // Import the EditTextBox widget with an alias
import '../Commons/grey_text_box.dart'; // Import the GreyTextBox widget
import '../Commons/my_cart_item.dart'; // Import the updated MyCartItem widget
import '../Commons/edit_textbox.dart'; // Import the EditTextBox widget
import '../Commons/header_withback.dart' as header; // Import the Header and CombinedAppBar widgets with an alias

class TestLayoutSakshi extends StatefulWidget {
  const TestLayoutSakshi({super.key});

  @override
  _TestLayoutSakshiState createState() => _TestLayoutSakshiState();
}

class _TestLayoutSakshiState extends State<TestLayoutSakshi> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController(); // Controller for GreyTextBox
  final double imageWidth = 100.0; // Define imageWidth with an appropriate value

  final List<Map<String, dynamic>> _cartItems = [
    {
      "imagePath": "assets/images/products/noImageFound.png", // Correct asset path
      "title": "Item 1",
      "description": "This is the description for item 1.",
      "price": 10.0
    },
    {
      "imagePath": "assets/images/products/noImageFound.png", // Correct asset path
      "title": "Item 2",
      "description": "This is the description for item 2.",
      "price": 20.0
    },
    {
      "imagePath": "assets/images/products/noImageFound.png", // Correct asset path
      "title": "Item 3",
      "description": "This is the description for item 3.",
      "price": 30.0
    },
  ]; // Sample cart items with image, title, description, and price

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  void _viewDetails(String title) {
    // Handle view details action
    print("View details for $title");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              const EditTextBox(), // Use the EditTextBox widget here
              const SizedBox(height: 16), // Add spacing between components
              GreyTextBox(nameController: nameController), // Pass the controller to GreyTextBox
              const SizedBox(height: 16), // Add spacing before cart items
              Expanded(
                child: ListView.builder(
                  itemCount: _cartItems.length,
                  itemBuilder: (context, index) {
                    return MyCartItem(
                      imagePath: _cartItems[index]["imagePath"], // Pass the correct asset path
                      title: _cartItems[index]["title"],
                      description: _cartItems[index]["description"],
                      price: _cartItems[index]["price"],
                      onDelete: () => _removeItem(index),
                      onViewDetails: () => _viewDetails(_cartItems[index]["title"]),
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