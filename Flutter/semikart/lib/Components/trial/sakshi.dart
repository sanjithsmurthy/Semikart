import 'package:flutter/material.dart';
import '../Commons/grey_text_box.dart'; // Import the BillingAddressScreen component
import '../Commons/searchbar.dart' as custom; // Import the SearchBar widget with an alias

class TestLayoutSakshi extends StatelessWidget {
  const TestLayoutSakshi({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Add 20px padding to top and bottom
              child: custom.SearchBar(searchController: searchController), // Add the SearchBar widget
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: BillingAddressScreen(), // Keep the BillingAddressScreen component
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const TestLayoutSakshi());
}