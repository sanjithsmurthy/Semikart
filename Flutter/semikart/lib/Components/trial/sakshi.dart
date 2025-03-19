import 'package:flutter/material.dart';
import '../Commons/searchbar.dart' as custom; // Import the SearchBar widget with an alias

class TestLayoutSakshi extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search Example'),
          backgroundColor: Color(0xFFA51414),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              custom.SearchBar(searchController: searchController),
              // Add more widgets here
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