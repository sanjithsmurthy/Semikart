import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/popup.dart';
import '../../managers/auth_manager.dart';
import 'profilepic.dart';
import '../common/red_button.dart';
import '../Login_SignUp/custom_text_field.dart';
import '../common/two_radios.dart';
import '../Login_SignUp/reset_password.dart';
import '../Login_SignUp/login_password.dart';
import '../../providers/profile_image_provider.dart';
import '../../providers/user_profile_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isEditing = false;

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

  // Removed all duplicate _sendResetLink methods to keep only one correct implementation

  // Removed all duplicate _sendResetLink methods to keep only one correct implementation

  // Removed duplicate _sendResetLink methods to keep only one correct implementation

  // Removed duplicate _sendResetLink methods to keep only one correct implementation

  // Removed duplicate _sendResetLink methods to keep only one correct implementation


  Future<void> _sendResetLink() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      CustomPopup.show(
        context: context,
        title: 'Error',
        message: 'Please enter your email address.',
        buttonText: 'OK',
        imagePath: 'public/assets/images/Alert.png',
      );
      return;
    }
    try {
      final success = await ref.read(authManagerProvider.notifier).sendPasswordReset(email);
      if (success) {
        CustomPopup.show(
          context: context,
          title: 'Success',
          message: 'Password reset link sent to $email',
          buttonText: 'OK',
          imagePath: 'public/assets/images/checksucccess.png',
        );
      } else {
        CustomPopup.show(
          context: context,
          title: 'Error',
          message: 'Failed to send reset link. Please try again.',
          buttonText: 'OK',
          imagePath: 'public/assets/images/Alert.png',
        );
      }
    } catch (e) {
      CustomPopup.show(
        context: context,
        title: 'Error',
        message: 'Failed to send reset link. Please try again.',
        buttonText: 'OK',
        imagePath: 'public/assets/images/Alert.png',
      );
    }
  }

  void _updateUserProfileProvider() {
    ref.read(userProfileProvider.notifier).state = UserProfile(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
    );
  }

  Future<void> _handleLogout() async {
    // --- Get the root navigator state BEFORE showing the dialog ---
    // We store it early to ensure we have the correct navigator instance.
    final rootNavigator = Navigator.of(context, rootNavigator: true);

    final confirmed = await CustomPopup.show(
      context: context, // Use the current context for the dialog
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      buttonText: 'Confirm',
      cancelButtonText: 'Cancel',
      imagePath: 'public/assets/images/Alert.png',
    );

    if (confirmed == true) {
      await ref.read(authManagerProvider.notifier).logout();

      // --- Use the stored rootNavigator instance ---
      // Check if the widget is still mounted before navigating
      if (mounted) {
        // Use the rootNavigator instance we captured earlier
        rootNavigator.pushNamedAndRemoveUntil('/', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final verticalSpacing = screenWidth * 0.03;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: verticalSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ProfilePicture(
                  onImageSelected: (File image) {
                    ref.read(profileImageProvider.notifier).state = image;
                  },
                ),
              ),
              SizedBox(height: verticalSpacing * 1.5),
              Row(
                children: [
                  Expanded(
                    child: RedButton(
                      label: 'Change Password',
                      height: screenWidth * 0.12,
                      onPressed: _sendResetLink,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: RedButton(
                      label: 'Logout',
                      height: screenWidth * 0.12,
                      onPressed: _handleLogout,
                    ),
                  ),
                ],
              ),
              SizedBox(height: verticalSpacing * 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'User Information',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      color: Colors.black,
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
                        isEditing = !isEditing;
                      });
                      if (!isEditing) _updateUserProfileProvider();
                    },
                  ),
                ],
              ),
              SizedBox(height: verticalSpacing),
              CustomTextField(
                controller: _firstNameController,
                label: 'First Name',
                height: screenWidth * 0.13,
                readOnly: !isEditing,
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Send Order Update Emails",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFA51414),
                      ),
                    ),
                  ),
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
                  Expanded(
                    child: Text(
                      "Send Order Update SMS",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFA51414),
                      ),
                    ),
                  ),
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
    );
  }
}
