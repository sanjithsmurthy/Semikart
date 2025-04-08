import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome
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
    // Set the status bar content to dark (black icons and text)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Set the status bar background color
        statusBarIconBrightness: Brightness.dark, // Set icons to dark
        statusBarBrightness: Brightness.light, // For iOS compatibility
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(66.0), // Match the header height
        child: CombinedAppBar(
          title: "Your Cart", // Title for the AppBar
          onBackPressed: () => _handleBackPress(context), // Back button functionality
        ),
      ),
      body: Container(
        color: Colors.white, // Match the header's background color
        child: SafeArea(
          child: CartPage(), // Implement the CartPage as the main body
        ),
      ),
      bottomNavigationBar: BottomBar.BottomNavBar(), // Use the alias for BottomNavBar
    );
  }

  static void _handleBackPress(BuildContext context) {
    Navigator.pop(context); // Navigate back to the previous page
  }
}

class TestLayoutSanjith extends StatelessWidget {
  const TestLayoutSanjith({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the status bar content to dark (black icons and text)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Set the status bar background color
        statusBarIconBrightness: Brightness.dark, // Set icons to dark
        statusBarBrightness: Brightness.light, // For iOS compatibility
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(66.0), // Match the header height
        child: CombinedAppBar(
          title: "Your Cart", // Title for the AppBar
          onBackPressed: () => _handleBackPress(context), // Back button functionality
        ),
      ),
      body: Container(
        color: Colors.white, // Match the header's background color
        child: SafeArea(
          child: CartPage(), // Implement the CartPage as the main body
        ),
      ),
      bottomNavigationBar: BottomBar.BottomNavBar(), // Use the alias for BottomNavBar
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TestLayoutSanjith(),
  ));
}
