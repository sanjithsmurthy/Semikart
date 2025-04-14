import 'package:flutter/material.dart';
import '../products/products_static.dart'; // Import the ProductsHeaderContent widget
import '../products/l2_page_redbox.dart'; // Import the L2PageRedBox widget

class ProductsL2Page extends StatelessWidget {
  const ProductsL2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products L2'),
        backgroundColor: const Color(0xFFA51414), // Red color
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Step 1: Implement products_static.dart
            const ProductsHeaderContent(),
            const SizedBox(height: 16), // Add spacing between components

            // Step 2: Implement l2_page_redbox.dart
            const RedBorderBox(text: 'L2 Component 1'),
            const SizedBox(height: 16),
            const RedBorderBox(text: 'L2 Component 2'),
            const SizedBox(height: 16),
            const RedBorderBox(text: 'L2 Component 3'),
            const SizedBox(height: 16),
            const RedBorderBox(text: 'L2 Component 4'),
          ],
        ),
      ),
    );
  }
}