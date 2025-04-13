import 'package:flutter/material.dart';
import '../common/header_withback.dart'; // Import the Header widget
import 'profilepic.dart'; // Import the ProfilePicture widget
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/popup.dart'; // Import the CustomPopup widget
import '../Login_SignUp/Loginpassword.dart'; // Import the LoginPasswordScreen
import '../Login_SignUp/reset_password.dart'; // Import the ResetPasswordScreen
import 'user_info.dart'; // Import the UserInfo widget
import '../common/ship_bill.dart'; // Import the ShipBillForm widget

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToFocusedField(BuildContext context, FocusNode focusNode) {
    // Delay to ensure the keyboard is fully visible
    Future.delayed(const Duration(milliseconds: 300), () {
      if (focusNode.hasFocus) {
        // Scroll to the focused text field
        _scrollController.animateTo(
          _scrollController.offset + 100, // Adjust offset as needed
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CombinedAppBar(
        title: 'Profile',
        onBackPressed: () {
          Navigator.pop(context); // Navigate back to the previous screen
        },
      ),
      body: SingleChildScrollView(
        controller: _scrollController, // Attach the scroll controller
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Ensure horizontal centering
              children: [
                const SizedBox(height: 16),

                // Profile Picture Section
                ProfilePicture(
                  onImageSelected: (image) {
                    // Handle profile picture update
                  },
                ),
                const SizedBox(height: 8),

                // Display Name
                const Text(
                  'GFXAgency',
                  style: TextStyle(
                    fontSize: 20, // Set font size to 20
                    fontWeight: FontWeight.normal, // Remove bold styling
                    fontFamily: 'Product Sans', // Use Product Sans font
                    color: Colors.black, // Set text color to black
                  ),
                ),
                const SizedBox(height: 24),

                // Logout Button
                RedButton(
                  label: 'Logout',
                  onPressed: () {
                    CustomPopup.show(
                      context: context,
                      title: 'Logout',
                      message: 'Are you sure you want to logout?',
                      buttonText: 'Confirm',
                      imagePath: 'public/assets/images/Alert.png', // Replace with your logout icon path
                    ).then((_) {
                      // Navigate to LoginPasswordScreen when popup button is clicked
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPasswordScreen()),
                      );
                    });
                  },
                  width: screenWidth * 0.8,
                  height: MediaQuery.of(context).size.height * 0.05, // Dynamically scalable height
                ),
                const SizedBox(height: 16),

                // Change Password Button
                RedButton(
                  label: 'Change Password',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  ResetPasswordScreen()),
                    );
                  },
                  width: screenWidth * 0.8,
                  height: MediaQuery.of(context).size.height * 0.05, // Dynamically scalable height
                ),
                const SizedBox(height: 32),

                // User Information Section
                UserInfo(
                  scrollToFocusedField: _scrollToFocusedField, // Pass the scroll function
                ),

                const SizedBox(height: 32), // Add spacing between UserInfo and ShipBillForm

                // Ship Bill Form Section
                ShipBillForm(
                  scrollToFocusedField: _scrollToFocusedField, // Pass the scroll function
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}