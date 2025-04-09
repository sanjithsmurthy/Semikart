import 'package:flutter/material.dart';
import '../home/bom_rfq.dart'; // Import the BomRfqCard widget

class TestLayoutSoma extends StatelessWidget {
  const TestLayoutSoma({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BOM RFQ"),
      ),
      body: const Center(
        child: BomRfqCard(), // Use the BomRfqCard as the main content
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
      body: const Center(
        child: BomRfqCard(), // Use the BomRfqCard as the main content
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SomaPage(), // Set SomaPage as the initial page
  ));
}
