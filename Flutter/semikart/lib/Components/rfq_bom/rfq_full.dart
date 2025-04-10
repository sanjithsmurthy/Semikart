import 'package:flutter/material.dart';
import 'upload_file.dart'; // Import the CustomSquare component
import 'RFQ_text_component.dart'; // Import the RFQTextComponent
import 'rfq_adress_details.dart'; // Import the RFQAddressDetails component
import '../common/header_withback.dart'; // Import your Header component
import '../common/bottom_bar.dart'; // Import your BottomBar component

class RFQFullPage extends StatelessWidget {
  const RFQFullPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color of the screen to white
      backgroundColor: Colors.white,

      // Add the AppBar using your HeaderWithBack widget
      appBar: HeaderWithBack(
        // You might need to pass parameters like title here, e.g.:
        // title: 'Request For Quote',
      ),

      // Main body content
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding inside the component
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add the CustomSquare component
              CustomSquare(),

              const SizedBox(height: 20),

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

              const SizedBox(height: 20), // Add some space at the bottom if needed before the bottom bar
            ],
          ),
        ),
      ),

      // Add the BottomNavigationBar using your BottomBar widget
      bottomNavigationBar: BottomNavBar(), // Instantiate your BottomBar widget
    );
  }
}
