import 'dart:io'; // <-- Add this line
import 'package:flutter/material.dart';
import '../../app_navigator.dart';
import 'upload_file.dart';
import 'RFQ_text_component.dart';
import 'rfq_adress_details.dart';
import '../common/popup.dart';
import '../../base_scaffold.dart';
import '../../services/rfq_service.dart'; // <-- Add this import


class RFQFullPage extends StatefulWidget {
  const RFQFullPage({Key? key}) : super(key: key);

  @override
  State<RFQFullPage> createState() => _RFQFullPageState();
}

class _RFQFullPageState extends State<RFQFullPage> {
  bool isFileUploaded = false;

  // Example fields for demonstration; replace with your actual data sources
  String email = '';
  String fullName = '';
  String mobileNo = '';
  String companyName = '';
  String address = '';
  String city = '';
  String state = '';
  String pinCode = '';
  String country = '';
  List<Map<String, dynamic>> parts = [];
  File? selectedFile;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        AppNavigator.openProductsRFQPage();
        return false;
      },
      child: Container(
        color: Colors.white, // Set the background color to white
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 50, left: 12, right: 12), // Adjusted padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSquare(
                  onFileUploaded: (bool uploaded) {
                    setState(() {
                      isFileUploaded = uploaded;
                    });
                  },
                ),
                const SizedBox(height: 5),
                if (!isFileUploaded)
                  RFQTextComponent(
                    onValidationChanged: (bool isValid) {
                      // Handle validation change logic here
                    },
                  ),
                // const SizedBox(height: ),
                RFQAddressDetails(
                  onValidationChanged: (bool isValid) {
                    // Handle validation change logic here
                  },
                  canSubmit: isFileUploaded,
                  onSubmit: () async {
                    try {
                      final response = await RFQService.submitRFQ(
                        email: email,
                        fullName: fullName,
                        mobileNo: mobileNo,
                        companyName: companyName,
                        address: address,
                        city: city,
                        state: state,
                        pinCode: pinCode,
                        country: country,
                        parts: parts,
                        file: selectedFile,
                      );
                      await CustomPopup.show(
                        context: context,
                        message: response['message'] ?? "RFQ submitted successfully.",
                        buttonText: "OK",
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BaseScaffold(),
                        ),
                      );
                    } catch (e) {
                      await CustomPopup.show(
                        context: context,
                        message: e.toString(),
                        buttonText: "OK",
                      );
                    }
                  },
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}