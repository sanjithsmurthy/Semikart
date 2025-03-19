import 'package:flutter/material.dart';
import '../Commons/bottom_bar_home.dart'; // Import the bottom_bar_home.dart file

class TestLayoutSanjith extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Header Title"), // Add your desired header title here
        backgroundColor: Color(0xFFA51414), // Optional: Set a custom background color
      ),
      body: Center(
        child: Text("Main Content Goes Here"), // Replace with your main content
      ),
      bottomNavigationBar: BottomNavBar(), // Bottom navigation bar
    );
  }
}