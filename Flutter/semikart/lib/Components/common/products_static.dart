import 'package:flutter/material.dart';
import 'header_withback.dart';
import 'RFQ_CTA.dart'; // Import the RFQ_CTA widget

class Productsstaticheader extends StatelessWidget {
  const Productsstaticheader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CombinedAppBar(
        title: 'Products', // Set your product category title here
        onBackPressed: () {
          Navigator.pop(context); // Standard back navigation
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Heading
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: const Text(
              'Electronic Components Categories Line Card',
              style: TextStyle(
                color: Color(0xFFA51414), // Red color (A51414)
                fontSize: 20, // Font size 20px
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16), // Add spacing before RFQ_CTA
          const RFQComponent(), // Add the RFQ_CTA widget here
        ],
      ),
    );
  }
}
