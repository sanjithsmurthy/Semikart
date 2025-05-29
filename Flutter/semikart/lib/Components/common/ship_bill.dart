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

  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController gstnController = TextEditingController();

  late final FocusNode nameFocusNode;
  late final FocusNode pincodeFocusNode;
  late final FocusNode address1FocusNode;
  late final FocusNode address2FocusNode;
  late final FocusNode landmarkFocusNode;
  late final FocusNode cityFocusNode;
  late final FocusNode stateFocusNode;
  late final FocusNode phoneFocusNode;
  late final FocusNode companyFocusNode;
  late final FocusNode gstnFocusNode;

  bool hasGSTN = false; // State for the GSTN radio button

  @override
  void initState() {
    super.initState();
    address1Controller = TextEditingController(text: widget.initialAddress1);
    address2Controller = TextEditingController(text: widget.initialAddress2);

    nameFocusNode = FocusNode();
    pincodeFocusNode = FocusNode();
    address1FocusNode = FocusNode();
    address2FocusNode = FocusNode();
    landmarkFocusNode = FocusNode();
    cityFocusNode = FocusNode();
    stateFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    companyFocusNode = FocusNode();
    gstnFocusNode = FocusNode();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    pincodeFocusNode.dispose();
    address1FocusNode.dispose();
    address2FocusNode.dispose();
    landmarkFocusNode.dispose();
    cityFocusNode.dispose();
    stateFocusNode.dispose();
    phoneFocusNode.dispose();
    companyFocusNode.dispose();
    gstnFocusNode.dispose();

    nameController.dispose();
    pincodeController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    landmarkController.dispose();
    cityController.dispose();
    stateController.dispose();
    phoneController.dispose();
    companyController.dispose();
    gstnController.dispose();

    super.dispose();
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

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
    // Define smaller font sizes
    const double gstnQuestionFontSize = 12.0;
    const double radioLabelFontSize = 12.0;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0 , bottom: 16.0), // Added top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreyTextBox(
              nameController: nameController,
              text: "Name*",
              focusNode: nameFocusNode,
              height: 34.0,
              onTap: () {},
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                _fieldFocusChange(context, nameFocusNode, pincodeFocusNode);
              },
            ),
            const SizedBox(height: 5),
            GreyTextBox(
              nameController: pincodeController,
              text: "Pincode*",
              height: 34.0,
              focusNode: pincodeFocusNode,
              onTap: () {},
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                _fieldFocusChange(context, pincodeFocusNode, address1FocusNode);
              },
            ),
            const SizedBox(height: 5),
            GreyTextBox(
              nameController: address1Controller,
              text: "Address 1*",
              height: 34.0,
              focusNode: address1FocusNode,
              onTap: () {},
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                _fieldFocusChange(context, address1FocusNode, address2FocusNode);
              },
            ),
            const SizedBox(height: 5),
            GreyTextBox(
              nameController: address2Controller,
              text: "Address 2",
              height: 34.0,
              focusNode: address2FocusNode,
              onTap: () {},
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                _fieldFocusChange(context, address2FocusNode, landmarkFocusNode);
              },
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: GreyTextBox(
                    nameController: landmarkController,
                    text: "Landmark",
                    height: 34.0,
                    focusNode: landmarkFocusNode,
                    onTap: () {},
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      _fieldFocusChange(context, landmarkFocusNode, cityFocusNode);
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: GreyTextBox(
                    nameController: cityController,
                    text: "City*",
                    height: 34.0,
                    focusNode: cityFocusNode,
                    onTap: () {},
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      _fieldFocusChange(context, cityFocusNode, stateFocusNode);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: GreyTextBox(
                    nameController: stateController,
                    text: "State*",
                    focusNode: stateFocusNode,
                    height: 34.0,
                    onTap: () {},
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      _fieldFocusChange(context, stateFocusNode, phoneFocusNode);
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: GreyTextBox(
                    nameController: phoneController,
                    text: "Phone Number*",
                    height: 34.0,
                    focusNode: phoneFocusNode,
                    onTap: () {},
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      _fieldFocusChange(context, phoneFocusNode, companyFocusNode);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            GreyTextBox(
              nameController: companyController,
              text: "Company Name (Optional)",
              height: 34.0,
              focusNode: companyFocusNode,
              onTap: () {},
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                _fieldFocusChange(context, companyFocusNode, gstnFocusNode);
              },
            ),
            const SizedBox(height: 12), // Adjusted spacing before the GSTN section

            // GSTN Question Text
            Text(
              "Do you have GSTN?", // Label on its own line
              style: TextStyle(
                color: const Color(0xFFA51414),
                fontSize: gstnQuestionFontSize*0.9,
              ),
            ),
            // const SizedBox(height: 2), // Small spacing between text and radio row

            // Row for Radio buttons and GSTN field
            Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically in the center
              children: [
                // Yes Radio
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 24,
                      child: Transform.scale(
                        scale: 0.8,
                        child: Radio<bool>(
                          value: true,
                          groupValue: hasGSTN,
                          activeColor: const Color(0xFFA51414),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) {
                            setState(() {
                              hasGSTN = value!;
                              if (hasGSTN) {
                                FocusScope.of(context).requestFocus(gstnFocusNode);
                              } else {
                                gstnController.clear(); // Clear if changed from Yes to No here
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                         setState(() {
                          hasGSTN = true;
                          FocusScope.of(context).requestFocus(gstnFocusNode);
                        });
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(fontSize: radioLabelFontSize),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8), // Spacing between Yes and No radio groups
                // No Radio
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     SizedBox(
                      height: 24,
                      width: 24,
                      child: Transform.scale(
                        scale: 0.8,
                        child: Radio<bool>(
                          value: false,
                          groupValue: hasGSTN,
                          activeColor: const Color(0xFFA51414),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) {
                            setState(() {
                              hasGSTN = value!;
                               if (!hasGSTN) {
                                gstnController.clear();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          hasGSTN = false;
                          gstnController.clear();
                        });
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(fontSize: radioLabelFontSize),
                      ),
                    ),
                  ],
                ),
                const Spacer(), // Added Spacer to push the GSTN field to the right
                // GSTN TextField - Remains with fixed width, pushed to the right by Spacer
                SizedBox(
                  width: 200.0, // Maintained specific width for the GSTN field
                  child: AbsorbPointer(
                    absorbing: !hasGSTN,
                    child: Opacity(
                      opacity: hasGSTN ? 1.0 : 0.5,
                      child: GreyTextBox(
                        height: 34.0, // Pass the desired height directly
                        nameController: gstnController,
                       
                        text: "GSTN", // Shortened placeholder
                        focusNode: gstnFocusNode,
                        onTap: () {},
                        // textInputAction and onEditingComplete might not be needed if it's the last interactive element in this logical group
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Center( // Wrap RedButton with Center widget
              child: RedButton(
                label: 'Update',
                onPressed: _saveAddress,
                width: 115,
                height: 34,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
