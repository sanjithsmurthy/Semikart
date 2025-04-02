import 'package:flutter/material.dart';
import 'rfq_bom/rfq_full.dart'; // Import the RFQFullPage widget

class SomaPage extends StatelessWidget {
  const SomaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Soma Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to RFQFullPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RFQFullPage()),
            );
          },
          child: const Text("Go to RFQ Full Page"),
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