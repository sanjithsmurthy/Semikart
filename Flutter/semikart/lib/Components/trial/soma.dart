import 'package:flutter/material.dart';
import '../rfq_bom/upload_file.dart'; // Import the UploadFile component
import '../rfq_bom/RFQ_text_component.dart'; // Import the RFQTextComponent class

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
        backgroundColor: Color(0xFFA51414), // Red color for the AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0), // Add padding around the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add the UploadFile component
              CustomSquare(), // Assuming CustomSquare is the main widget in upload_file.dart

              SizedBox(height: 20), // Add spacing between components

              // Add the RFQTextComponent
              RFQTextComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
