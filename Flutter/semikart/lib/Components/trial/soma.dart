import 'package:flutter/material.dart';
import '../products/product_details_noimage.dart'; // Import the ProductDetailsNoImage component

class TestLayoutSoma extends StatelessWidget {
  const TestLayoutSoma({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Layout Soma"),
      ),
      body: Center(
        child: ProductDetailsNoImage(
          manufacturerPartNumber: '103004194-5501', // Example part number
          manufacturerImagePath:
              'public/assets/images/products/noImageFound.png', // Example image URL
          eatonImagePath:
              'public/assets/images/products/Eaton.png', // Local asset path for Eaton image
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: TestLayoutSoma(), // Set TestLayoutSoma as the initial page
  ));
}
