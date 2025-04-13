import 'package:flutter/material.dart';
import '../products/prodl1_component.dart'; // Import the CustomSquareBox component

class TestLayoutSoma extends StatelessWidget {
  const TestLayoutSoma({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Layout Soma"),
      ),
      body: Center(
        child: CustomSquareBox(
          imagePath:
              'public/assets/icon/circuit_protection.png', // Example image URL
          text: 'Circuit Protection',
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
