import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'grey_text_box.dart'; // Import the GreyTextBox widget
import 'red_button.dart'; // Import the RedButton widget

class ShipBillForm extends StatefulWidget {
  final String? initialAddress1;
  final String? initialAddress2;
  final Function(BuildContext, FocusNode) scrollToFocusedField; // Accept scrollToFocusedField as a parameter

  const ShipBillForm({
    super.key,
    this.initialAddress1,
    this.initialAddress2,
    required this.scrollToFocusedField, // Required parameter
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

  // Focus Nodes for each text field
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode pincodeFocusNode = FocusNode();
  final FocusNode address1FocusNode = FocusNode();
  final FocusNode address2FocusNode = FocusNode();
  final FocusNode landmarkFocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  final FocusNode stateFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode companyFocusNode = FocusNode();
  final FocusNode gstnFocusNode = FocusNode();

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GreyTextBox(
            nameController: nameController,
            text: "Name*",
            focusNode: nameFocusNode, // Attach FocusNode
            onTap: () => widget.scrollToFocusedField(context, nameFocusNode), // Scroll when focused
          ),
          const SizedBox(height: 16),
          GreyTextBox(
            nameController: pincodeController,
            text: "Pincode*",
            focusNode: pincodeFocusNode, // Attach FocusNode
            onTap: () => widget.scrollToFocusedField(context, pincodeFocusNode), // Scroll when focused
          ),
          const SizedBox(height: 16),
          GreyTextBox(
            nameController: address1Controller,
            text: "Address 1*",
            focusNode: address1FocusNode, // Attach FocusNode
            onTap: () => widget.scrollToFocusedField(context, address1FocusNode), // Scroll when focused
          ),
          const SizedBox(height: 16),
          GreyTextBox(
            nameController: address2Controller,
            text: "Address 2",
            focusNode: address2FocusNode, // Attach FocusNode
            onTap: () => widget.scrollToFocusedField(context, address2FocusNode), // Scroll when focused
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GreyTextBox(
                  nameController: landmarkController,
                  text: "Landmark",
                  focusNode: landmarkFocusNode, // Attach FocusNode
                  onTap: () => widget.scrollToFocusedField(context, landmarkFocusNode), // Scroll when focused
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GreyTextBox(
                  nameController: cityController,
                  text: "City*",
                  focusNode: cityFocusNode, // Attach FocusNode
                  onTap: () => widget.scrollToFocusedField(context, cityFocusNode), // Scroll when focused
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
                  focusNode: stateFocusNode, // Attach FocusNode
                  onTap: () => widget.scrollToFocusedField(context, stateFocusNode), // Scroll when focused
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GreyTextBox(
                  nameController: phoneController,
                  text: "Phone Number*",
                  focusNode: phoneFocusNode, // Attach FocusNode
                  onTap: () => widget.scrollToFocusedField(context, phoneFocusNode), // Scroll when focused
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GreyTextBox(
            nameController: companyController,
            text: "Company Name (Optional)",
            focusNode: companyFocusNode, // Attach FocusNode
            onTap: () => widget.scrollToFocusedField(context, companyFocusNode), // Scroll when focused
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
                focusNode: gstnFocusNode, // Attach FocusNode
                onTap: () => widget.scrollToFocusedField(context, gstnFocusNode), // Scroll when focused
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
    );
  }
}
