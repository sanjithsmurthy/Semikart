import 'package:flutter/material.dart';
import '../rfq_bom/upload_file.dart'; // Import the UploadFile component
import '../rfq_bom/RFQ_text_component.dart'; // Import the RFQTextComponent class
import '../rfq_bom/RFQ_Adress_details.dart'; // Import the RFQAddressDetails class
import '../common/header_withback.dart'; // Import the HeaderWithBack component
import '../common/bottom_bar.dart'; // Import the BottomNavBar component
// import '../profile/user_info.dart'; // Import the UserInfo widget

class TestLayoutSoma extends StatelessWidget {
  const TestLayoutSoma({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CombinedAppBar(
        title: "RFQ Full Page",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSquare(),
              const SizedBox(height: 30),
              const RFQTextComponent(),
              const SizedBox(height: 30),
              RFQAddressDetails(
                onSubmit: () {
                  print('Address Details Submitted!');
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class SomaPage extends StatelessWidget {
  const SomaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TestLayoutSoma(); // Now it uses the full RFQ layout
  }
}

void main() {
  runApp(const MaterialApp(
    home: SomaPage(),
  ));
}
