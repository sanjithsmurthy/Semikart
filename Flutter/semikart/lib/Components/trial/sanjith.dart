import 'package:flutter/material.dart';
import '../common/bottom_bar.dart' as BottomBar; // Alias for bottom_bar.dart
import '../common/header_withback.dart'; // Import the Header and CombinedAppBar components
import '../cart/cart_page.dart'; // Import the CartPage component

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SanjithCartPage(),
  ));
}

class SanjithCartPage extends StatelessWidget {
  const SanjithCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CombinedAppBar(
        title: "Your Cart", // Title for the AppBar
        onBackPressed: () => _handleBackPress(context), // Back button functionality
      ),
      body: CartPage(), // Implement the CartPage as the main body
      bottomNavigationBar: BottomBar.BottomNavBar(), // Use the alias for BottomNavBar
    );
  }

  static void _handleBackPress(BuildContext context) {
    Navigator.pop(context); // Navigate back to the previous page
  }
}

class TestLayoutSanjith extends StatelessWidget {
  const TestLayoutSanjith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CombinedAppBar(
        title: "Your Cart", // Title for the AppBar
        onBackPressed: () => _handleBackPress(context), // Back button functionality
      ),
      body: CartPage(), // Implement the CartPage as the main body
      bottomNavigationBar: BottomBar.BottomNavBar(), // Use the alias for BottomNavBar
    );
  }

  static void _handleBackPress(BuildContext context) {
    Navigator.pop(context); // Navigate back to the previous page
  }
}
