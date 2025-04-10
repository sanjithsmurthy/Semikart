import 'package:flutter/material.dart';
import '../common/header.dart'; // Import Header
import '../common/bottom_bar.dart'; // Import BottomNavBar

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const Header(
          onLogoTap: null, // You can define a callback if needed
        ),
        body: Center(
          child: Text(
            'Home Page Content',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        bottomNavigationBar: const BottomNavBar(), // Use BottomNavBar as the bottom bar
      ),
    );
  }
}