import 'package:flutter/material.dart';
import '../Commons/custom_text_field.dart';
import '../rfq_bom/upload_file.dart'; // Import the CustomSquare class

class TestLayoutSoma extends StatefulWidget {
  const TestLayoutSoma({super.key});

  @override
  State<TestLayoutSoma> createState() => _TestLayoutSomaState();
}

class _TestLayoutSomaState extends State<TestLayoutSoma> {
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
          child: CustomSquare(), // Use the CustomSquare widget
        ),
      ),
    );
  }
}
