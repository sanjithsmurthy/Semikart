import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../Commons/bottom_bar_home.dart'; // Import the bottom_bar_home.dart file
=======
import '../Commons/custom_text_field.dart';

class TestLayoutSanjith extends StatefulWidget {
  @override
  State<TestLayoutSanjith> createState() => _TestLayoutSanjithState();
}

class _TestLayoutSanjithState extends State<TestLayoutSanjith> {
  final TextEditingController _testController = TextEditingController();

  @override
  void dispose() {
    _testController.dispose();
    super.dispose();
  }
>>>>>>> ce951737676315185ee86f4581e10a2789e976c6

class TestLayoutSanjith extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavBar(); // Replace with the main widget from bottom_bar_home.dart
  }
}