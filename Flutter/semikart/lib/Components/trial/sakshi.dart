import 'package:flutter/material.dart';
import '../shippingtextfield.dart'; // Import the BillingAddressScreen

class TestLayoutSakshi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BillingAddressScreen(),
    );
  }
}

void main() {
  runApp(TestLayoutSakshi());
}