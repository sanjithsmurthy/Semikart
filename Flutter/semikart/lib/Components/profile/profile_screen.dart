import 'package:flutter/material.dart';
import 'dart:io'; // Still needed by the dummy callback type
import 'profilepic.dart'; // Import the custom ProfilePicture widget
import '../common/red_button.dart'; // Import the RedButton widget
import '../Login_SignUp/custom_text_field.dart'; // Import CustomTextField
import '../common/two_radios.dart'; // Import TwoRadioButtons
import '../Login_SignUp/reset_password.dart';
import '../Login_SignUp/login_password.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // State variable to track edit mode
  bool isEditing = false;

  // Controllers for text fields
  final _firstNameController = TextEditingController(text: 'John');
  final _lastNameController = TextEditingController(text: 'Doe');
  final _companyNameController = TextEditingController(text: 'Semikart');
  final _emailController = TextEditingController(text: 'john.doe@example.com');
  final _phoneController = TextEditingController(text: '1234567890');
  final _altPhoneController = TextEditingController(text: '0987654321');
  final _gstinController = TextEditingController(text: 'GSTIN12345');
  final _typeController = TextEditingController(text: 'Type1');
  final _sourceController = TextEditingController(text: 'Source1');

  @override
  void dispose() {
    // Dispose controllers
    _firstNameController.dispose();
    _lastNameController.dispose();
    _companyNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _altPhoneController.dispose();
    _gstinController.dispose();
    _typeController.dispose();
    _sourceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final verticalSpacing = screenWidth * 0.03;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: verticalSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Section
                Center(
                  child: ProfilePicture(
                    onImageSelected: (File image) {
                      print("Image selected: ${image.path}");
                    },
                  ),
                ),

                SizedBox(height: verticalSpacing * 1.5),

                // Row for Red Buttons
                Row(
                  children: [
                    Expanded(
                      child: RedButton(
                        label: 'Change Password',
                         // White button variant
                        height: screenWidth * 0.12,
                        onPressed: () {
                         Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                           );
                          // Add functionality for Change Password
                        },
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03), // Spacing between buttons
                    Expanded(
                      child: RedButton(
                        label: 'Logout',
                        // White button variant
                        height: screenWidth * 0.12,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPasswordNewScreen()),
                           );
                          // Add functionality for Logout
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: verticalSpacing * 1.5),

                // Row for Edit Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Text(
                      'User Information',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isEditing ? Icons.check : Icons.edit,
                        color: const Color(0xFFA51414),
                        size: screenWidth * 0.07,
                      ),
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing; // Toggle edit mode
                        });
                      },
                    ),
                  ],
                ),

                SizedBox(height: verticalSpacing),

                // Custom Text Fields
                CustomTextField(
                  controller: _firstNameController,
                  label: 'First Name',
                  height: screenWidth * 0.13,
                  readOnly: !isEditing, // Make read-only if not in edit mode
                ),
                SizedBox(height: verticalSpacing),
                CustomTextField(
                  controller: _lastNameController,
                  label: 'Last Name',
                  height: screenWidth * 0.13,
                  readOnly: !isEditing,
                ),
                SizedBox(height: verticalSpacing),
                CustomTextField(
                  controller: _companyNameController,
                  label: 'Company Name',
                  height: screenWidth * 0.13,
                  readOnly: !isEditing,
                ),
                SizedBox(height: verticalSpacing),
                CustomTextField(
                  controller: _emailController,
                  label: 'Your Email',
                  height: screenWidth * 0.13,
                  readOnly: !isEditing,
                ),
                SizedBox(height: verticalSpacing),

                // Row for Phone Numbers
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        height: screenWidth * 0.13,
                        readOnly: !isEditing,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: CustomTextField(
                        controller: _altPhoneController,
                        label: 'Alternate No.',
                        height: screenWidth * 0.13,
                        readOnly: !isEditing,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: verticalSpacing),
                CustomTextField(
                  controller: _gstinController,
                  label: 'GSTIN NO',
                  height: screenWidth * 0.13,
                  readOnly: !isEditing,
                ),
                SizedBox(height: verticalSpacing),

                // Row for Type and Source
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _typeController,
                        label: 'Type',
                        height: screenWidth * 0.13,
                        readOnly: !isEditing,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: CustomTextField(
                        controller: _sourceController,
                        label: 'Source',
                        height: screenWidth * 0.13,
                        readOnly: !isEditing,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: verticalSpacing * 1.5),

                // Radio Button Rows
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.02)),
                    Expanded(
                      child: Text(
                        "Send Order Update Emails",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFFA51414),
                        ),
                        softWrap: false,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.005),
                    Expanded(
                      child: TwoRadioButtons(
                        forceHorizontalLayout: true,
                        options: ['Yes', 'No'],
                        initialSelection: 0,
                        onSelectionChanged: (value) => print("Email Radio: $value"),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: verticalSpacing),

                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.02)),
                    Expanded(
                      child: Text(
                        "Send Order Update SMS",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFFA51414),
                        ),
                        softWrap: false,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.005),
                    Expanded(
                      child: TwoRadioButtons(
                        forceHorizontalLayout: true,
                        options: ['Yes', 'No'],
                        initialSelection: 0,
                        onSelectionChanged: (value) => print("SMS Radio: $value"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}