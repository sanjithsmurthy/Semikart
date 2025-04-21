import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'grey_text_box.dart'; // Import the GreyTextBox widget
import 'red_button.dart'; // Import the RedButton widget

class ShipBillForm extends StatefulWidget {
  final String? initialAddress1;
  final String? initialAddress2;

  const ShipBillForm({
    super.key,
    this.initialAddress1,
    this.initialAddress2,
  });

  @override
  State<ShipBillForm> createState() => _ShipBillFormState();
}

class _ShipBillFormState extends State<ShipBillForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  late final TextEditingController address1Controller;
  late final TextEditingController address2Controller;

  @override
  void initState() {
    super.initState();
    address1Controller = TextEditingController(text: widget.initialAddress1);
    address2Controller = TextEditingController(text: widget.initialAddress2);
  }

  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController gstnController = TextEditingController();

  bool hasGSTN = false; // State for the GSTN radio button

  void _saveAddress() {
    // Validate all required fields
    if (nameController.text.isEmpty ||
        pincodeController.text.isEmpty ||
        address1Controller.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty ||
        phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Validate pincode is numeric
    if (!RegExp(r'^[0-9]+$').hasMatch(pincodeController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pincode must contain only numbers'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Validate phone number is numeric
    if (!RegExp(r'^[0-9]+$').hasMatch(phoneController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number must contain only numbers'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Validate GSTN if "Yes" is selected
    if (hasGSTN && gstnController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('GSTN is required when "Do you have GSTN?" is set to Yes'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final formData = {
      'name': nameController.text,
      'pincode': pincodeController.text,
      'address1': address1Controller.text,
      'address2': address2Controller.text,
      'landmark': landmarkController.text,
      'city': cityController.text,
      'state': stateController.text,
      'phone': phoneController.text,
      'company': companyController.text,
      'gstn': gstnController.text,
    };
    Navigator.pop(context, formData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Address updated successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

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
              text: "Name*",
            ),
            const SizedBox(height: 16),
            GreyTextBox(
              nameController: pincodeController,
              text: "Pincode*",
            ),
            const SizedBox(height: 16),
            GreyTextBox(
              nameController: address1Controller,
              text: "Address 1*",
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
                    text: "City*",
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
                    text: "State*",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GreyTextBox(
                    nameController: phoneController,
                    text: "Phone Number*",
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
                color: Color(0xFFA51414),
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
            AbsorbPointer(
              absorbing: !hasGSTN,
              child: Opacity(
                opacity: hasGSTN ? 1.0 : 0.5,
                child: GreyTextBox(
                  nameController: gstnController,
                  text: "GSTN (Optional)",
                ),
              ),
            ),
            const SizedBox(height: 32),
            RedButton(
              label: 'Update',
              onPressed: _saveAddress,
              width: double.infinity,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
