import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'edit_textbox.dart';
import 'edit_textbox2.dart';
import 'items_dropdown.dart';
import 'red_button.dart';
import 'ship_bill.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isChecked = false;

  // Billing Address Fields
  String? name;
  String? pincode;
  String? address1;
  String? address2;
  String? landmark;
  String? city;
  String? state;
  String? phone;
  String? company;
  String? gstn;

  // Shipping Address Fields
  String? shippingName;
  String? shippingPincode;
  String? shippingAddress1;
  String? shippingAddress2;
  String? shippingLandmark;
  String? shippingCity;
  String? shippingState;
  String? shippingPhone;
  String? shippingCompany;
  String? shippingGstn;

  // Function to scroll to the focused field
  void _scrollToFocusedField(BuildContext context, FocusNode focusNode) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (focusNode.hasFocus) {
        Scrollable.ensureVisible(
          focusNode.context!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              EditTextBox(
                address1: address1,
                address2: address2,
                onEdit: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShipBillForm(
                        initialAddress1: address1,
                        initialAddress2: address2,
                        scrollToFocusedField: _scrollToFocusedField, // Pass scrollToFocusedField
                      ),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      name = result['name'];
                      pincode = result['pincode'];
                      address1 = result['address1'];
                      address2 = result['address2'];
                      landmark = result['landmark'];
                      city = result['city'];
                      state = result['state'];
                      phone = result['phone'];
                      company = result['company'];
                      gstn = result['gstn'];
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: isChecked,
                onChanged: (bool? value) async {
                  if (value == true) {
                    // Check if all mandatory billing fields are filled
                    if (name == null || name!.isEmpty ||
                        pincode == null || pincode!.isEmpty ||
                        address1 == null || address1!.isEmpty ||
                        city == null || city!.isEmpty ||
                        state == null || state!.isEmpty ||
                        phone == null || phone!.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Missing Information'),
                          content: const Text('Please fill all mandatory billing address fields first (Name, Pincode, Address1, City, State, Phone)'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                      return;
                    }

                    // Copy all billing fields to shipping
                    setState(() {
                      isChecked = true;
                      shippingName = name;
                      shippingPincode = pincode;
                      shippingAddress1 = address1;
                      shippingAddress2 = address2;
                      shippingLandmark = landmark;
                      shippingCity = city;
                      shippingState = state;
                      shippingPhone = phone;
                      shippingCompany = company;
                      shippingGstn = gstn;
                    });
                  } else {
                    // Clear all shipping address fields when unchecked
                    setState(() {
                      isChecked = false;
                      shippingName = null;
                      shippingPincode = null;
                      shippingAddress1 = null;
                      shippingAddress2 = null;
                      shippingLandmark = null;
                      shippingCity = null;
                      shippingState = null;
                      shippingPhone = null;
                      shippingCompany = null;
                      shippingGstn = null;
                    });
                  }
                },
                title: const Text(
                  "Billing Address same as shipping address",
                  style: TextStyle(fontSize: 16),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Color(0xFFA51414),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),
              EditTextBox2(
                title: 'Shipping Address',
                address1: shippingAddress1,
                address2: shippingAddress2,
                onEdit: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShipBillForm(
                        initialAddress1: shippingAddress1,
                        initialAddress2: shippingAddress2,
                        scrollToFocusedField: _scrollToFocusedField, // Pass scrollToFocusedField
                      ),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      shippingName = result['name'];
                      shippingPincode = result['pincode'];
                      shippingAddress1 = result['address1'];
                      shippingAddress2 = result['address2'];
                      shippingLandmark = result['landmark'];
                      shippingCity = result['city'];
                      shippingState = result['state'];
                      shippingPhone = result['phone'];
                      shippingCompany = result['company'];
                      shippingGstn = result['gstn'];
                      if (isChecked) {
                        name = shippingName;
                        pincode = shippingPincode;
                        address1 = shippingAddress1;
                        address2 = shippingAddress2;
                        landmark = shippingLandmark;
                        city = shippingCity;
                        state = shippingState;
                        phone = shippingPhone;
                        company = shippingCompany;
                        gstn = shippingGstn;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 8),
              // Additional UI components...
            ],
          ),
        ),
      ),
    );
  }
}
