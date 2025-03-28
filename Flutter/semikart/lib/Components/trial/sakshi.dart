import 'package:flutter/material.dart';
import '../Commons/searchbar.dart' as custom; // Import the SearchBar widget with an alias
import '../Commons/edit_textbox.dart'; // Import the EditTextBox widget
import '../Commons/grey_text_box.dart'; // Import the GreyTextBox widget

class TestLayoutSakshi extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController(); // Controller for GreyTextBox

  TestLayoutSakshi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Components'),
          backgroundColor: Color(0xFFA51414),
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
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(TestLayoutSakshi());
}