import 'package:flutter/material.dart';
import '../common/header_withback.dart'; // Import the Header widget
import 'profilepic.dart'; // Import the ProfilePicture widget
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/popup.dart'; // Import the CustomPopup widget
import '../Login_SignUp/Loginpassword.dart'; // Import the LoginPasswordScreen
import '../Login_SignUp/reset_password.dart'; // Import the ResetPasswordScreen
import 'user_info.dart'; // Import the UserInfo widget
import '../common/ship_bill.dart'; // Import the ShipBillForm widget

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                  height: 40,
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
                  height: 40,
                ),
                const SizedBox(height: 32), // Add spacing between buttons and UserInfo

                // User Information Section
                const UserInfo(), // Add the UserInfo widget here

                const SizedBox(height: 32), // Add spacing between UserInfo and ShipBillForm

                // Ship Bill Form Section
                const ShipBillForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}