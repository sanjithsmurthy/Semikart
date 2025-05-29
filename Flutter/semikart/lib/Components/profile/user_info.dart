import 'package:flutter/material.dart';
import '../login_signup/custom_text_field.dart';
import '../common/two_radios.dart';

class UserInfo extends StatelessWidget {
  final Function(BuildContext, FocusNode) scrollToFocusedField;

  const UserInfo({
    super.key,
    required this.scrollToFocusedField, // Accept the scroll function
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final fieldWidth = isSmallScreen ? double.infinity : screenWidth * 0.8;

    // Focus Nodes for each text field
    final FocusNode firstNameFocusNode = FocusNode();
    final FocusNode lastNameFocusNode = FocusNode();
    final FocusNode companyNameFocusNode = FocusNode();
    final FocusNode emailFocusNode = FocusNode();
    final FocusNode phoneNumberFocusNode = FocusNode();
    final FocusNode alternateNumberFocusNode = FocusNode();
    final FocusNode gstinFocusNode = FocusNode();
    final FocusNode typeFocusNode = FocusNode();
    final FocusNode sourceFocusNode = FocusNode();

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

    return Container(
      width: fieldWidth,
      padding: const EdgeInsets.all(8.0), // Reduced padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Edit button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Align with text fields
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "User Information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal, // Removed bold styling
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
          const SizedBox(height: 8), // Reduced vertical gap

          CustomTextField(
            label: "First Name",
            controller: firstNameController,
            focusNode: firstNameFocusNode, 
            onTap: () => scrollToFocusedField(context, firstNameFocusNode),
            // No inputTextFontSize provided, so it will use the default (e.g., 16.0)
          ),
          const SizedBox(height: 4), 

          CustomTextField(
            label: "Last Name",
            controller: lastNameController,
            focusNode: lastNameFocusNode, 
            onTap: () => scrollToFocusedField(context, lastNameFocusNode), 
            // inputTextFontSize: 14.0, // Explicitly set to a smaller size
          ),
          const SizedBox(height: 4), 

          CustomTextField(
            label: "Company Name",
            controller: companyNameController,
            focusNode: companyNameFocusNode, 
            onTap: () => scrollToFocusedField(context, companyNameFocusNode), 
            // No inputTextFontSize provided, so it will use the default (e.g., 16.0)
          ),
          const SizedBox(height: 4), 

          CustomTextField(
            label: "Your Email",
            controller: emailController,
            focusNode: emailFocusNode, 
            onTap: () => scrollToFocusedField(context, emailFocusNode), 
            // inputTextFontSize: 14.0, // Explicitly set to a smaller size
          ),
          const SizedBox(height: 4), 

          // Row with Phone & Alternate
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: "Phone Number",
                  controller: phoneNumberController,
                  focusNode: phoneNumberFocusNode, 
                  onTap: () => scrollToFocusedField(context, phoneNumberFocusNode),
                  // No inputTextFontSize provided, so it will use the default
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomTextField(
                  label: "Alternate No.",
                  controller: alternateNumberController,
                  focusNode: alternateNumberFocusNode, 
                  onTap: () => scrollToFocusedField(context, alternateNumberFocusNode), 
                  // inputTextFontSize: 14.0, // Explicitly set to a smaller size
                ),
              ),
            ],
          ),
          const SizedBox(height: 4), 

          CustomTextField(
            label: "GSTIN NO.",
            controller: gstinController,
            focusNode: gstinFocusNode, 
            onTap: () => scrollToFocusedField(context, gstinFocusNode), 
            // No inputTextFontSize provided, so it will use the default
          ),
          const SizedBox(height: 4), 

          // Row with Type & Source
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: "Type",
                  controller: typeController,
                  focusNode: typeFocusNode, 
                  onTap: () => scrollToFocusedField(context, typeFocusNode), 
                  // inputTextFontSize: 14.0, 
// print('Input Text Font Size: 14.0');smaller size
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomTextField(
                  label: "Source",
                  controller: sourceController,
                  focusNode: sourceFocusNode, 
                  onTap: () => scrollToFocusedField(context, sourceFocusNode),
                  // No inputTextFontSize provided, so it will use the default
                ),
              ),
            ],
          ),
          const SizedBox(height: 4), 

          // Radio: Email Updates
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Send Order Update Emails",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal, 
                      color: Color(0xFFA51414),
                    ),
                    softWrap: false, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                ),
                TwoRadioButtons(
                  options: ['Yes', 'No'],
                  initialSelection: 0,
                  onSelectionChanged: (value) => print("Email Radio: $value"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4), 

          // Radio: SMS Updates
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "Send Order Updates SMS",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal, 
                      color: Color(0xFFA51414),
                    ),
                  ),
                ),
                TwoRadioButtons(
                  options: ['Yes', 'No'],
                  initialSelection: 0,
                  onSelectionChanged: (value) => print("SMS Radio: $value"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
