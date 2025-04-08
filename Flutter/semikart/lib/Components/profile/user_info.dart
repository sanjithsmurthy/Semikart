import 'package:flutter/material.dart';
import '../Login_SignUp/custom_text_field.dart';
import '../common/two_radios.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final fieldWidth = isSmallScreen ? double.infinity : screenWidth * 0.8;

    // Controllers
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final companyNameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final alternateNumberController = TextEditingController();
    final gstinController = TextEditingController();
    final typeController = TextEditingController();
    final sourceController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: fieldWidth,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Edit button
                Padding(
                  padding: const EdgeInsets.only(left: 39.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "User Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFFA51414)),
                        onPressed: () => print("Edit pressed"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "First Name",
                  controller: firstNameController,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "Last Name",
                  controller: lastNameController,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "Company Name",
                  controller: companyNameController,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "Your Email",
                  controller: emailController,
                ),
                const SizedBox(height: 16),

                // Row with Phone & Alternate
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "Phone Number",
                        controller: phoneNumberController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        label: "Alternate No.",
                        controller: alternateNumberController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "GSTIN NO.",
                  controller: gstinController,
                ),
                const SizedBox(height: 16),

                // Row with Type & Source
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "Type",
                        controller: typeController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        label: "Source",
                        controller: sourceController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Radio: Email Updates
                Padding(
                  padding: const EdgeInsets.only(left: 39.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Send Order Updates Emails",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA51414),
                          ),
                        ),
                      ),
                      TwoRadioButtons(
                        options: ['Yes', 'No'],
                        initialSelection: 0,
                        onSelectionChanged: (value) =>
                            print("Email Radio: $value"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Radio: SMS Updates
                Padding(
                  padding: const EdgeInsets.only(left: 39.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Send Order Updates SMS",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA51414),
                          ),
                        ),
                      ),
                      TwoRadioButtons(
                        options: ['Yes', 'No'],
                        initialSelection: 0,
                        onSelectionChanged: (value) =>
                            print("SMS Radio: $value"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
