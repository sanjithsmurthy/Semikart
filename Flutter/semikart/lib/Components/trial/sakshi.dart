import 'package:flutter/material.dart';
import '../Commons/searchbar.dart' as custom; // Import the SearchBar widget with an alias
import '../Commons/grey_text_box.dart'; // Import the GreyTextBox widget

class TestLayoutSakshi extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  TestLayoutSakshi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Example Page'),
          backgroundColor: Color(0xFFA51414),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              custom.SearchBar(searchController: searchController), // Add the SearchBar widget
              SizedBox(height: 20),
              // GreyTextBox(
              //   title: 'Shipping Address',
              //   address: 'Magadi Main Rd, next to Prasanna Theatre, Cholurpalya, Bengaluru, Karnataka 560023',
              //   onEdit: () {
              //     // Handle edit action here
              //     print('Edit button pressed');
              //   },
              // ), // Add the GreyTextBox widget
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