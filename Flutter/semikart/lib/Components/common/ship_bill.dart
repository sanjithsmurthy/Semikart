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
            const Text(
              "Name",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            GreyTextBox(nameController: nameController),
            const SizedBox(height: 16),

            const Text(
              "Pincode",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            GreyTextBox(nameController: pincodeController),
            const SizedBox(height: 16),

            const Text(
              "Address 1",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            GreyTextBox(nameController: address1Controller),
            const SizedBox(height: 16),

            const Text(
              "Address 2",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            GreyTextBox(nameController: address2Controller),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Landmark",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      GreyTextBox(nameController: landmarkController),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "City",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      GreyTextBox(nameController: cityController),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "State",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      GreyTextBox(nameController: stateController),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Phone Number",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      GreyTextBox(nameController: phoneController),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              "Company Name(Optional)",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            GreyTextBox(nameController: companyController),
            const SizedBox(height: 16),

            const Text(
              "Do you have GSTN?",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: hasGSTN,
                      activeColor: Colors.red,
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
                      activeColor: Colors.red,
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

            const Text(
              "GSTN(Optional)",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            GreyTextBox(nameController: gstnController),
          ],
        ),
      ),
    );
  }
}