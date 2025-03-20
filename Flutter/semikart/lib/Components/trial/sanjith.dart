import 'package:flutter/material.dart';
import '../Commons/bottom_bar_home.dart'; // Import the bottom_bar_home.dart file
import '../Commons/header.dart'; // Import the header.dart file

class TestLayoutSanjith extends StatelessWidget {
  const TestLayoutSanjith({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(), // Use the updated Header as the AppBar
      body: Center(
        child: Text("Main Content Goes Here"), // Replace with your main content
      ),
      bottomNavigationBar: BottomNavBar(), // Bottom navigation bar
    );
  }
}
