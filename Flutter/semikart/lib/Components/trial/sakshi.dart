import 'package:flutter/material.dart';
import '../Commons/grey_text_box.dart'; // Import the BillingAddressScreen component

class TestLayoutSakshi extends StatelessWidget {
  const TestLayoutSakshi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example Page'),
          backgroundColor: const Color(0xFFA51414),
        ),
        body: const BillingAddressScreen(), // Use the BillingAddressScreen component here
      ),
    );
  }
}

void main() {
  runApp(const TestLayoutSakshi());
}