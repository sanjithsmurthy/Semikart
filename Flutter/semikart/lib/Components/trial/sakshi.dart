import 'package:flutter/material.dart';
import '../Commons/custom_text_field.dart';  // Ensure this import is correct

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Components'),
        backgroundColor: Color(0xFFA51414),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: _testController,
                label: "Test Field",
              ),
              // Add more components here to test
            ],
          ),
        ),
      ),
    );
  }
}