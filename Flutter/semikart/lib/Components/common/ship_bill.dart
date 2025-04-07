import 'package:flutter/material.dart';
import 'grey_text_box.dart'; // Import the GreyTextBox widget

class ShipBillForm extends StatefulWidget {
  const ShipBillForm({super.key});

  @override
  State<ShipBillForm> createState() => _ShipBillFormState();
}

class _ShipBillFormState extends State<ShipBillForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController gstnController = TextEditingController();

  bool hasGSTN = false; // State for the GSTN radio button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreyTextBox(
              nameController: nameController,
              text: "Name",
            ),
            const SizedBox(height: 16),
            GreyTextBox(
              nameController: pincodeController,
              text: "Pincode",
            ),
            const SizedBox(height: 16),
            GreyTextBox(
              nameController: address1Controller,
              text: "Address 1",
            ),
            const SizedBox(height: 16),
            GreyTextBox(
              nameController: address2Controller,
              text: "Address 2",
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GreyTextBox(
                    nameController: landmarkController,
                    text: "Landmark",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GreyTextBox(
                    nameController: cityController,
                    text: "City",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GreyTextBox(
                    nameController: stateController,
                    text: "State",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GreyTextBox(
                    nameController: phoneController,
                    text: "Phone Number",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GreyTextBox(
              nameController: companyController,
              text: "Company Name (Optional)",
            ),
            const SizedBox(height: 16),
            const Text(
              "Do you have GSTN?",
              style: TextStyle(
                color: Color(0xFFA51414), // Same style as other headings
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: hasGSTN,
                      activeColor: const Color(0xFFA51414),
                      onChanged: (value) {
                        setState(() {
                          hasGSTN = value!;
                        });
                      },
                    ),
                    const Text("Yes"),
                  ],
                ),
                Row(
                  children: [
                    Radio<bool>(
                      value: false,
                      groupValue: hasGSTN,
                      activeColor: const Color(0xFFA51414),
                      onChanged: (value) {
                        setState(() {
                          hasGSTN = value!;
                        });
                      },
                    ),
                    const Text("No"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            GreyTextBox(
              nameController: gstnController,
              text: "GSTN (Optional)",
            ),
          ],
        ),
      ),
    );
  }
}