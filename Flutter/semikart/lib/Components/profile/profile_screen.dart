import 'package:flutter/material.dart';
import '../common/header.dart'; // Import the Header widget
import 'profilepic.dart'; // Import the ProfilePicture widget
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/popup.dart'; // Import the CustomPopup widget
import '../login_signup/login_password.dart'; // Import the LoginPasswordScreen
import '../login_signup/reset_password.dart'; // Import the ResetPasswordScreen
import 'user_info.dart'; // Import the UserInfo widget

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToFocusedField(BuildContext context, FocusNode focusNode) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (focusNode.hasFocus) {
        _scrollController.animateTo(
          _scrollController.offset + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    debugPrint("ProfileScreen is being rendered");

    return Scaffold(
      appBar: const Header(
        showBackButton: true,
        title: 'Profile',
        onBackPressed: null, // Navigator.pop is runtime, so no const here
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: screenWidth,
                minHeight: screenHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // Prevent unbounded height
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
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      
                      color: Colors.black,
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
                        imagePath: 'assets/images/Alert.png', // Ensure this path is correct
                      ).then((_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) =>  LoginPasswordNewScreen()),
                        );
                      });
                    },
                    width: screenWidth * 0.8, // Runtime value, so no const
                    height: screenHeight * 0.05, // Runtime value, so no const
                  ),
                  const SizedBox(height: 16),

                  // Change Password Button
                  RedButton(
                    label: 'Change Password',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                      );
                    },
                    width: screenWidth * 0.8, // Runtime value, so no const
                    height: screenHeight * 0.05, // Runtime value, so no const
                  ),
                  const SizedBox(height: 32),

                  // User Information Section
                  UserInfo(
                    scrollToFocusedField: _scrollToFocusedField,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}