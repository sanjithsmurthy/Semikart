import 'package:flutter/material.dart';
import 'upload_file.dart'; // Import the CustomSquare component
import 'RFQ_text_component.dart'; // Import the RFQTextComponent
import 'rfq_adress_details.dart'; // Import the RFQAddressDetails component

class RFQFullPage extends StatelessWidget {
  const RFQFullPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color of the screen to white
      backgroundColor: Colors.white,

      // Main body content
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.all(16.0), // Add padding inside the component
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add the CustomSquare component
              CustomSquare(),

              const SizedBox(
                  height: 40), // Increased height by 4 pixels (20 + 4)

              // Add the RFQTextComponent
              RFQTextComponent(),

              const SizedBox(height: 20),

              // Add the RFQAddressDetails component
              RFQAddressDetails(
                onSubmit: () {
                  // Define what happens when the submit button is pressed
                  print('Submit button pressed!');
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
