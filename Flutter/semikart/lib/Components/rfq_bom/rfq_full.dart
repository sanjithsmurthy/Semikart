import 'package:flutter/material.dart';
import '../../app_navigator.dart';
import 'upload_file.dart';
import 'rfq_text_component.dart';
import 'rfq_adress_details.dart';
import '../common/popup.dart';
import '../home/home_page.dart';

class RFQFullPage extends StatefulWidget {
  const RFQFullPage({Key? key}) : super(key: key);

  @override
  State<RFQFullPage> createState() => _RFQFullPageState();
}

class _RFQFullPageState extends State<RFQFullPage> {
  bool isFileUploaded = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        AppNavigator.openProductsRFQPage();
        return false;
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 40),
              if (!isFileUploaded) RFQTextComponent(
                onValidationChanged: (bool isValid) {
                  // Handle validation change logic here
                },
              ),
              const SizedBox(height: 20),
              RFQAddressDetails(
                onValidationChanged: (bool isValid) {
                  // Handle validation change logic here
                },
                canSubmit: isFileUploaded,
                onSubmit: () {
                  CustomPopup.show(
                    context: context,
                    message: "RFQ submitted successfully.",
                    buttonText: "OK",
                  ).then((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePageContent()),
                    );
                  });
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
