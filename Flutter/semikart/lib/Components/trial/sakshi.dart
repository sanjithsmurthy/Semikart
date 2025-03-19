import 'package:flutter/material.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import '../Commons/custom_text_field.dart';  // Add this import
=======
import '../Commons/custom_text_field.dart';  // Ensure this import is correct
>>>>>>> ce951737676315185ee86f4581e10a2789e976c6
=======
import '../Login_SignUp/custom_text_field.dart';  // Add this import
>>>>>>> 4234d34212e98d65481cb4d9f6740342899da71f

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