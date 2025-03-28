import 'package:flutter/material.dart';
import '../rfq_bom/upload_file.dart'; // Import the UploadFile component
import '../rfq_bom/RFQ_text_component.dart'; // Import the RFQTextComponent class
import '../rfq_bom/RFQ_Adress_details.dart'; // Import the RFQAddressDetails class

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

              SizedBox(height: 20), // Add spacing between components

              // Add the RFQAddressDetails component
              RFQAddressDetails(
                onSubmit: () {
                  print('Address Details Submitted!');
                },
              ),

              SizedBox(height: 20), // Add spacing before the link

              // Link to navigate to the combined view
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CombinedViewScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'View All Components in One Frame',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFA51414), // Link color
                      decoration:
                          TextDecoration.underline, // Underline the text
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// New screen to display all components in one frame
class CombinedViewScreen extends StatelessWidget {
  const CombinedViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Components'),
        backgroundColor: Color(0xFFA51414), // Red color for the AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0), // Add padding around the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // UploadFile component
              CustomSquare(), // Assuming CustomSquare is the main widget in upload_file.dart

              SizedBox(height: 20), // Add spacing between components

              // RFQTextComponent
              RFQTextComponent(),

              SizedBox(height: 20), // Add spacing between components

              // RFQAddressDetails component
              RFQAddressDetails(
                onSubmit: () {
                  print('Address Details Submitted!');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
