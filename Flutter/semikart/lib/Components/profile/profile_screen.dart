import 'package:flutter/material.dart';
import 'dart:io'; // Still needed by the dummy callback type
import 'profilepic.dart'; // Import the custom ProfilePicture widget
import '../common/red_button.dart'; // Import the RedButton widget
import '../Login_SignUp/custom_text_field.dart'; // Import CustomTextField
import '../Login_SignUp/reset_password.dart'; // Keep import if needed for navigation
import '../common/two_radios.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Dummy callback function - does nothing in this simplified version
  void _doNothing(File image) {
    // This function is required by ProfilePicture, but we don't
    // handle the image selection in this screen anymore.
    print("Image selected (but not handled in ProfileScreen): ${image.path}");
  }

  // Dummy controllers - For real usage, convert to StatefulWidget and create separate controllers
  static final _sampleFieldController = TextEditingController();
  static final _phoneController = TextEditingController();
  static final _altPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Define padding and spacing dynamically
    final horizontalPadding = screenWidth * 0.05;
    final verticalSpacing = screenWidth * 0.04; // Define vertical spacing based on width
    final buttonSpacing = screenWidth * 0.04; // Dynamic spacing between buttons
    final titleFontSize = screenWidth * 0.05; // Dynamic font size for title (approx 20 on medium screens)
    final iconSize = screenWidth * 0.07; // Dynamic size for icon
    final textFieldHeight = screenWidth * 0.14; // Define a height for text fields
    final fieldSpacing = screenWidth * 0.03; // Spacing between fields in a row

    return Scaffold(
      // appBar: AppBar(title: const Text('Profile')), // Optional AppBar
      body: SafeArea( // Added SafeArea
        child: SingleChildScrollView( // Added SingleChildScrollView
          child: Padding( // Add padding around the entire Column
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalSpacing), // Add vertical padding too
            child: Column(
              children: [
                // Profile Picture Section using the custom widget
                Padding(
                  // No horizontal padding needed here as it's handled by the outer Padding
                  padding: const EdgeInsets.only(top: 0), // Ensure zero top padding
                  child: Center( // Horizontally center the ProfilePicture widget
                    child: ProfilePicture(
                      // imageUrl: 'YOUR_INITIAL_IMAGE_URL_HERE', // Optional: Provide an initial image URL
                      onImageSelected: _doNothing, // Pass the dummy callback
                    ),
                  ),
                ),

                // Use dynamic spacing
                SizedBox(height: verticalSpacing * 1.5),

                // Row for the two buttons using Expanded for flexible scaling
                Row(
                  children: [
                    Expanded( // Make Button 1 flexible
                      child: RedButton(
                        label: 'Change Password',
                        isWhiteButton: true, // Make it outlined
                        height: screenWidth * 0.12,
                        // width: screenWidth * 0.24, // REMOVE fixed width when using Expanded
                        onPressed: () {
                          // Navigator.pushReplacement(
                          //         context,
                          //         MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                          //      );
                          print('Button 1 pressed');
                          // Add functionality for Button 1
                        },
                      ),
                    ),
                    SizedBox(width: buttonSpacing), // Dynamic spacing between buttons
                    Expanded( // Make Button 2 flexible
                      child: RedButton(
                        label: 'Logout',
                        isWhiteButton: true, // Make it outlined
                        // width: screenWidth * 0.24, // REMOVE fixed width when using Expanded
                        height: screenWidth * 0.12, // Adjust height as needed
                        onPressed: () {
                          print('Button 2 pressed');
                          // Add functionality for Button 2
                        },
                      ),
                    ),
                  ],
                ),

                // Use dynamic spacing below buttons
                SizedBox(height: verticalSpacing * 1.5),

                // --- User Information Title Row ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Pushes items to ends
                  children: [
                    Text(
                      'User Information',
                      style: TextStyle(
                        // fontFamily: 'Product Sans', // Uncomment if Product Sans is configured
                        fontSize: titleFontSize, // Use dynamic font size
                        color: Colors.black,
                        fontWeight: FontWeight.normal, // Regular weight
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: const Color(0xFFA51414), // Red color
                        size: iconSize, // Use dynamic icon size
                      ),
                      onPressed: () {
                        print('Edit User Info pressed');
                        // Add functionality for edit button
                      },
                    ),
                  ],
                ),

                // Add spacing between title row and text field
                SizedBox(height: screenWidth*0.015),

                // First Name
                CustomTextField(
                  controller: _sampleFieldController, // Use the dummy controller
                  label: 'First Name', // Provide a label
                  height: screenWidth*0.13, // Adjust height as needed
                  // CustomTextField uses 90% width internally by default
                ),

                // Add spacing between title row and text field
                SizedBox(height: screenWidth*0.03),

                // Last Name
                CustomTextField(
                  controller: _sampleFieldController, // Use the dummy controller
                  label: 'Last Name',
                  height: screenWidth*0.13, // Provide a label
                                    // CustomTextField uses 90% width internally by default
                ),

                // Add spacing between title row and text field
                SizedBox(height: screenWidth*0.03),

                // Company Name
                CustomTextField(
                  controller: _sampleFieldController, // Use the dummy controller
                  label: 'Company Name', 
                  height: screenWidth*0.13,// Provide a label
                                    // CustomTextField uses 90% width internally by default
                ),

                // Add spacing between title row and text field
                SizedBox(height: screenWidth*0.03),

                // Your Email
                CustomTextField(
                  controller: _sampleFieldController, // Use the dummy controller
                  label: 'Your Email', 
                  height: screenWidth*0.13,// Provide a label
                                    // CustomTextField uses 90% width internally by default
                ),

                // Add spacing before the row of phone numbers
                SizedBox(height: screenWidth*0.03), // Use standard vertical spacing

                // --- Row for Phone Numbers ---
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _phoneController, // Use specific controller
                        label: 'Phone Number',
                        height: textFieldHeight, // Apply the defined height
                        width: null, // Crucial: Allow Expanded to control width
                      ),
                    ),
                    SizedBox(width: fieldSpacing), // Horizontal spacing between fields
                    Expanded(
                      child: CustomTextField(
                        controller: _altPhoneController, // Use specific controller
                        label: 'Alternate No.',
                        height: textFieldHeight, // Apply the defined height
                        width: null, // Crucial: Allow Expanded to control width
                      ),
                    ),
                  ],
                ),


                // Add spacing between title row and text field
                SizedBox(height: screenWidth*0.03),

                // Your Email
                CustomTextField(
                  controller: _sampleFieldController, // Use the dummy controller
                  label: 'GSTIN NO', 
                  height: screenWidth*0.13,// Provide a label
                                    // CustomTextField uses 90% width internally by default
                ),

                // Add spacing before the row of phone numbers
                SizedBox(height: screenWidth*0.03), // Use standard vertical spacing

                // --- Row for Phone Numbers ---
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _phoneController, // Use specific controller
                        label: 'Type',
                        height: textFieldHeight, // Apply the defined height
                        width: null, // Crucial: Allow Expanded to control width
                      ),
                    ),
                    SizedBox(width: fieldSpacing), // Horizontal spacing between fields
                    Expanded(
                      child: CustomTextField(
                        controller: _altPhoneController, // Use specific controller
                        label: 'Source',
                        height: textFieldHeight, // Apply the defined height
                        width: null, // Crucial: Allow Expanded to control width
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: screenWidth*0.03), // Use standard vertical spacing

                // --- Row for Phone Numbers ---
                Row(
                  children: [
                     Padding(padding: EdgeInsets.only(left: screenWidth*0.02)),
                    Expanded(
                      child: Text(
                    "Send Order Update Emails",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal, // Removed bold styling
                      color: Color(0xFFA51414),
                    ),
                    softWrap: false, // Prevent wrapping to the next line
                    // overflow: TextOverflow.ellipsis, // Truncate text if it overflows
                  ),
                    ),
                    SizedBox(width: screenWidth*0.005), // Horizontal spacing between fields
                    Expanded(
                      child: TwoRadioButtons(
                       forceHorizontalLayout: true, // Force horizontal layout
                  options: ['Yes', 'No'],
                  initialSelection: 0,
                  onSelectionChanged: (value) => print("Email Radio: $value"),
                ),
                    ),
                  ],
                ),

                SizedBox(height: screenWidth*0.03), // Use standard vertical spacing

                // --- Row for Phone Numbers ---
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: screenWidth*0.02)), // Add padding to the left
                    Expanded(
                      child: Text(
                    "Send Order Update SMS",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal, // Removed bold styling
                      color: Color(0xFFA51414),
                    ),
                    softWrap: false, // Prevent wrapping to the next line
                    // overflow: TextOverflow.ellipsis, // Truncate text if it overflows
                  ),
                    ),
                    SizedBox(width: screenWidth*0.003), // Horizontal spacing between fields
                    Expanded(
                      child: TwoRadioButtons(
                       forceHorizontalLayout: true, // Force horizontal layout
                  options: ['Yes', 'No'],
                  initialSelection: 0,
                  onSelectionChanged: (value) => print("Email Radio: $value"),
                ),
                    ),
                  ],
                ),

                
                

                // Add other widgets below if needed
                // SizedBox(height: verticalSpacing),
                // const Text('Other Content...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}