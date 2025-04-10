import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome
import '../common/bottom_bar.dart' as BottomBar; // Alias for bottom_bar.dart
import '../common/header_withback.dart'; // Import the Header and CombinedAppBar components
import '../cart/cart_page.dart'; // Import the CartPage component

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TestLayoutSanjith(), // Set TestLayoutSanjith as the home page
  ));
}

class TestLayoutSanjith extends StatelessWidget {
  const TestLayoutSanjith({super.key});

  static void _handleBackPress(BuildContext context) {
    Navigator.pop(context); // Navigate back to the previous page
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar and navigation bar styles for this screen

    return SafeArea( // Wrap the entire Scaffold in SafeArea
      child: Scaffold(
        extendBodyBehindAppBar: false, // Ensure the body does not extend behind the AppBar
        backgroundColor: Colors.white, // Set the background color to white
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(66.0), // Match the header height
          child: CombinedAppBar(
            title: "Your Cart", // Title for the AppBar
            onBackPressed: () => _handleBackPress(context), // Back button functionality
          ),
        ),
        body: CartPage(), // Implement the CartPage as the main body
        bottomNavigationBar: BottomBar.BottomNavBar(), // Use the alias for BottomNavBar
      ),
    );
  }
}
