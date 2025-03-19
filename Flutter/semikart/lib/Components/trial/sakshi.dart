import 'package:flutter/material.dart';
import '../Commons/custom_text_field.dart';  // Add this import
import '../Commons/custom_text_field.dart';  // Ensure this import is correct
import '../Login_SignUp/custom_text_field.dart';  // Add this import


class TestLayoutSakshi extends StatefulWidget {
  @override
  State<TestLayoutSakshi> createState() => _TestLayoutSakshiState();  // Fixed class name
}

class _TestLayoutSakshiState extends State<TestLayoutSakshi> {  // Fixed class name
  final TextEditingController _testController = TextEditingController();

  @override
  void dispose() {
    _testController.dispose();
    super.dispose();
  }

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