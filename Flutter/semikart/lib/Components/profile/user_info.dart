import 'package:flutter/material.dart';
import '../Login_SignUp/custom_text_field.dart';
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
            focusNode: firstNameFocusNode, // Attach focus node
            onTap: () => scrollToFocusedField(context, firstNameFocusNode), // Scroll when focused
          ),
          const SizedBox(height: 4), // Reduced vertical gap

          CustomTextField(
            label: "Last Name",
            controller: lastNameController,
            focusNode: lastNameFocusNode, // Attach focus node
            onTap: () => scrollToFocusedField(context, lastNameFocusNode), // Scroll when focused
          ),
          const SizedBox(height: 4), // Reduced vertical gap

          CustomTextField(
            label: "Company Name",
            controller: companyNameController,
            focusNode: companyNameFocusNode, // Attach focus node
            onTap: () => scrollToFocusedField(context, companyNameFocusNode), // Scroll when focused
          ),
          const SizedBox(height: 4), // Reduced vertical gap

          CustomTextField(
            label: "Your Email",
            controller: emailController,
            focusNode: emailFocusNode, // Attach focus node
            onTap: () => scrollToFocusedField(context, emailFocusNode), // Scroll when focused
          ),
          const SizedBox(height: 4), // Reduced vertical gap

          // Row with Phone & Alternate
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: "Phone Number",
                  controller: phoneNumberController,
                  focusNode: phoneNumberFocusNode, // Attach focus node
                  onTap: () => scrollToFocusedField(context, phoneNumberFocusNode), // Scroll when focused
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomTextField(
                  label: "Alternate No.",
                  controller: alternateNumberController,
                  focusNode: alternateNumberFocusNode, // Attach focus node
                  onTap: () => scrollToFocusedField(context, alternateNumberFocusNode), // Scroll when focused
                ),
              ),
            ],
          ),
          const SizedBox(height: 4), // Reduced vertical gap

          CustomTextField(
            label: "GSTIN NO.",
            controller: gstinController,
            focusNode: gstinFocusNode, // Attach focus node
            onTap: () => scrollToFocusedField(context, gstinFocusNode), // Scroll when focused
          ),
          const SizedBox(height: 4), // Reduced vertical gap

          // Row with Type & Source
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: "Type",
                  controller: typeController,
                  focusNode: typeFocusNode, // Attach focus node
                  onTap: () => scrollToFocusedField(context, typeFocusNode), // Scroll when focused
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomTextField(
                  label: "Source",
                  controller: sourceController,
                  focusNode: sourceFocusNode, // Attach focus node
                  onTap: () => scrollToFocusedField(context, sourceFocusNode), // Scroll when focused
                ),
              ),
            ],
          ),
          const SizedBox(height: 4), // Reduced vertical gap

          // Radio: Email Updates
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Align with text fields
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Send Order Update Emails",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal, // Removed bold styling
                      color: Color(0xFFA51414),
                    ),
                    softWrap: false, // Prevent wrapping to the next line
                    overflow: TextOverflow.ellipsis, // Truncate text if it overflows
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
          const SizedBox(height: 4), // Reduced vertical gap

          // Radio: SMS Updates
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Align with text fields
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "Send Order Updates SMS",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal, // Removed bold styling
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
