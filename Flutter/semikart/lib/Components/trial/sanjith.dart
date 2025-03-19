import 'package:flutter/material.dart';

// Import the bottom_bar_home.dart file

class TestLayoutSanjith extends StatefulWidget {
  @override
  State<TestLayoutSanjith> createState() => _TestLayoutSanjithState();
}

class _TestLayoutSanjithState extends State<TestLayoutSanjith> {
  final TextEditingController _testController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Layout Sanjith'),
      ),
      body: Center(
        child: TextField(
          controller: _testController,
          decoration: InputDecoration(
            labelText: 'Enter text',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _testController.dispose();
    super.dispose();
  }

}
