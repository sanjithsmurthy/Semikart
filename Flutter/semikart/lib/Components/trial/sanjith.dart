import 'package:flutter/material.dart';
import '../Commons/bottom_bar.dart'; // Import the bottom_bar_home.dart file
import '../Commons/header.dart'; // Import the header.dart file
import '../Commons/search_failed.dart'; // Import the search_failed.dart file

class TestLayoutSanjith extends StatelessWidget {
  const TestLayoutSanjith({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(), // Use the updated Header as the AppBar
      body: const SearchFailed(), // Display the SearchFailed component
      bottomNavigationBar: BottomNavBar(), // Bottom navigation bar
    );
  }
}
