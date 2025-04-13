import 'package:flutter/material.dart';
import 'header_withback.dart';

class ProductsL1Page extends StatelessWidget {
  const ProductsL1Page({super.key});

  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: const EdgeInsets.all(16.0), // Add padding around the text
            child: const Text(
              'Electronic Components Categories Line Card',
              style: TextStyle(
                color: Color(0xFFA51414), // Red color (A51414)
                fontSize: 30, // Font size 20px
                fontWeight: FontWeight.bold, // Make it bold
              ),
              textAlign: TextAlign.center, // Center align the text
            ),
          ),
          // Add additional content below if needed
        ],
      ),
    );
  }
}
