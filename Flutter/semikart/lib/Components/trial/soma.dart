import 'package:flutter/material.dart';
// import '../rfq_bom/upload_file.dart'; // Import the UploadFile component
// import '../rfq_bom/RFQ_text_component.dart'; // Import the RFQTextComponent class
// import '../rfq_bom/RFQ_Adress_details.dart'; // Import the RFQAddressDetails class
// import '../common/header_withback.dart'; // Import the HeaderWithBack component
// import '../common/bottom_bar.dart'; // Import the BottomNavBar component
// import '../rfq_bom/rfq_full.dart'; // Import the RFQFullPage widget
import '../profile/user_info.dart'; // Import the UserInfo widget

class TestLayoutSoma extends StatelessWidget {
  const TestLayoutSoma({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   // Set the background color of the screen to white
    //   backgroundColor: Colors.white,

    //   // Use HeaderWithBack as the app bar
    //   appBar: CombinedAppBar(
    //     title: "RFQ Full Page", // Title for the app bar
    //     onBackPressed: () {
    //       Navigator.pop(context); // Navigate back to the previous page
    //     },
    //   ),

    //   // Main body content
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: const EdgeInsets.all(20.0), // Add padding around the content
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           // Upload File Component
    //           const CustomSquare(), // Assuming CustomSquare is the main widget in upload_file.dart

    //           const SizedBox(height: 30), // Spacing between components

    //           // RFQ Text Component
    //           const RFQTextComponent(), // Display RFQTextComponent

    //           const SizedBox(height: 30), // Spacing between components

    //           // RFQ Address Details Component
    //           RFQAddressDetails(
    //             onSubmit: () {
    //               print('Address Details Submitted!');
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),

    //   // BottomNavBar implemented as the bottom bar
    //   bottomNavigationBar:
    //       const BottomNavBar(), // BottomNavBar from bottom_bar.dart
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Information"),
      ),
      body: const UserInfo(), // Use the UserInfo widget as the main content
    );
  }
}

class SomaPage extends StatelessWidget {
  const SomaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Information"),
      ),
      body: const UserInfo(), // Use the UserInfo widget as the main content
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SomaPage(), // Set SomaPage as the initial page
  ));
}
