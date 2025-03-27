import 'package:flutter/material.dart';
import '../Commons/searchbar.dart' as custom; // Import the SearchBar widget with an alias
import '../Commons/grey_text_box.dart'; // Import the GreyTextBox widget

class TestLayoutSakshi extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Grey Text Box Example'),
          backgroundColor: Color(0xFFA51414),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              custom.SearchBar(searchController: searchController), // Add the SearchBar widget
              SizedBox(height: 20),
              GreyTextBox(), // Add the GreyTextBox widget
              SizedBox(height: 20),
              // Text(
              //   'Other Content Goes Here',
              //   style: TextStyle(fontSize: 18),
              // ),
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