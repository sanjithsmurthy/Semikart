import 'package:flutter/material.dart';
import '../Commons/searchbar.dart' as custom; // Import the SearchBar widget with an alias
import '../Commons/edit_textbox.dart'; // Import the EditTextBox widget
import '../Commons/grey_text_box.dart'; // Import the GreyTextBox widget
import '../Commons/my_cart.dart'; // Import the MyCartItem widget

class TestLayoutSakshi extends StatefulWidget {
  const TestLayoutSakshi({super.key});

  @override
  _TestLayoutSakshiState createState() => _TestLayoutSakshiState();
}

class _TestLayoutSakshiState extends State<TestLayoutSakshi> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController(); // Controller for GreyTextBox
  final List<String> _cartItems = ["Item 1", "Item 2", "Item 3"]; // Sample cart items

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
              // const EditTextBox(), // Use the EditTextBox widget here
              const SizedBox(height: 16), // Add spacing between components
              GreyTextBox(nameController: nameController), // Pass the controller to GreyTextBox
              const SizedBox(height: 16), // Add spacing before cart items
              Expanded(
                child: ListView.builder(
                  itemCount: _cartItems.length,
                  itemBuilder: (context, index) {
                    return MyCartItem(
                      itemName: _cartItems[index],
                      onDelete: () => _removeItem(index), itemDescription: 'This is the description', onViewDetails: () {  },
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