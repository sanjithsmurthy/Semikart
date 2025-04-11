import 'package:flutter/material.dart';
import '../products/prodl1_component.dart'; // Import the CustomSquareBox widget

class TestLayoutSoma extends StatelessWidget {
  const TestLayoutSoma({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BOM RFQ"),
      ),
      body: Center(
        child: CustomSquareBox(
          imagePath: 'public/assets/images/products/Category Icons_Circuit Protection.png', // Replace with your image path
          text: 'Circuit Protection',
        ),
      ),
    );
  }
}

class SomaPage extends StatelessWidget {
  const SomaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BOM RFQ"),
      ),
      body: Center(
        child: CustomSquareBox(
          imagePath: 'public/assets/images/products/Category Icons_Circuit Protection.png', // Replace with your image path
          text: 'Circuit Protection',
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SomaPage(), // Set SomaPage as the initial page
  ));
}