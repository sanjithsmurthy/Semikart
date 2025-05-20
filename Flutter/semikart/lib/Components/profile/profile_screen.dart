import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/popup.dart';
import '../../managers/auth_manager.dart';
import '../../services/user_service.dart';
import 'profilepic.dart';
import '../common/red_button.dart';
import '../Login_SignUp/custom_text_field.dart';
import '../common/two_radios.dart';
import '../../providers/profile_image_provider.dart';
import 'dart:developer'; // For logging

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isEditing = false;
  bool _isSaving = false;
  String? _profileImageUrl;
  bool _controllersPopulated = false; // Flag to prevent overwriting edits
  String? _lastProcessedUserId; // Track user ID to repopulate on user change

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _altPhoneController = TextEditingController();
  final _gstinController = TextEditingController();
  final _typeController = TextEditingController();
  final _sourceController = TextEditingController();

  bool _sendEmails = true;

  @override
  void initState() {
    super.initState();
  }

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

  Future<void> _updateUserProfile() async {
    final user = ref.read(authManagerProvider).user;
    if (user == null) {
      CustomPopup.show(context: context, title: 'Error', message: 'Not logged in.', buttonText: 'OK', imagePath: 'public/assets/images/Alert.png');
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final dataToUpdate = {
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'companyName': _companyNameController.text.trim(),
      'phoneNumber': _phoneController.text.trim(),
      'altPhoneNumber': _altPhoneController.text.trim(),
      'gstin': _gstinController.text.trim(),
      'userType': _typeController.text.trim(),
      'leadSource': _sourceController.text.trim(),
      'sendOrderEmails': _sendEmails,
      'updatedAt': DateTime.now().toIso8601String(), // Replaced FieldValue.serverTimestamp()
    };

    try {
      final userService = ref.read(userServiceProvider);
      await userService.updateUserProfile(user.id, dataToUpdate); // Changed user.uid to user.id
      CustomPopup.show(
        context: context,
        title: 'Success',
        message: 'Profile updated successfully!',
        buttonText: 'OK',
        imagePath: 'public/assets/images/checksucccess.png',
      );
      setState(() {
        isEditing = false;
        _controllersPopulated = true;
      });
    } catch (e) {
      CustomPopup.show(
        context: context,
        title: 'Error',
        message: 'Failed to update profile. Please try again.',
        buttonText: 'OK',
        imagePath: 'public/assets/images/Alert.png',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _handleLogout() async {
    final rootNavigator = Navigator.of(context, rootNavigator: true);

    final confirmed = await CustomPopup.show(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      buttonText: 'Confirm',
      cancelButtonText: 'Cancel',
      imagePath: 'public/assets/images/Alert.png',
    );

    if (confirmed == true) {
      await ref.read(authManagerProvider.notifier).logout();

      if (mounted) {
        rootNavigator.pushNamedAndRemoveUntil('/', (route) => false);
      }
    }
  }

  // Updated to use DocumentData instead of DocumentSnapshot
  void _populateControllers(DocumentData? userDoc) {
    final authUser = ref.read(authManagerProvider).user;
    String? currentUserId = authUser?.id; // Changed from uid to id
    
    if (_lastProcessedUserId != currentUserId) {
      _controllersPopulated = false;
      _lastProcessedUserId = currentUserId;
    }

    if (!_controllersPopulated && currentUserId != null) {
      String firstName = '';
      String lastName = '';
      String companyName = '';
      String email = authUser?.email ?? '';
      String phone = '';
      String altPhone = '';
      String gstin = '';
      String type = '';
      String source = '';
      bool sendEmails = true;
      String? imageUrl = authUser?.photoURL;

      if (userDoc != null && userDoc.exists) {
        final data = userDoc.data();
        firstName = data['firstName'] ?? '';
        lastName = data['lastName'] ?? '';
        companyName = data['companyName'] ?? '';
        email = data['email'] ?? email;
        phone = data['phoneNumber'] ?? '';
        altPhone = data['altPhoneNumber'] ?? '';
        gstin = data['gstin'] ?? '';
        type = data['userType'] ?? '';
        source = data['leadSource'] ?? '';
        sendEmails = data['sendOrderEmails'] ?? true;
        imageUrl = data['profileImageUrl'] as String? ?? imageUrl;
      } else if (authUser?.displayName != null) {
        List<String> nameParts = authUser!.displayName!.split(' ');
        if (nameParts.isNotEmpty) firstName = nameParts.first;
        if (nameParts.length > 1) lastName = nameParts.sublist(1).join(' ');
      }

      _firstNameController.text = firstName;
      _lastNameController.text = lastName;
      _companyNameController.text = companyName;
      _emailController.text = email;
      _phoneController.text = phone;
      _altPhoneController.text = altPhone;
      _gstinController.text = gstin;
      _typeController.text = type;
      _sourceController.text = source;
      _sendEmails = sendEmails;
      _profileImageUrl = imageUrl;

      _controllersPopulated = true;

      if (userDoc == null || !userDoc.exists) {
        isEditing = true;
      }
    } else if (currentUserId == null) {
      _firstNameController.clear();
      _lastNameController.clear();
      _companyNameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _altPhoneController.clear();
      _gstinController.clear();
      _typeController.clear();
      _sourceController.clear();
      _sendEmails = true;
      _profileImageUrl = null;
      _controllersPopulated = false;
      _lastProcessedUserId = null;
    }
  }

  Future<void> _uploadProfileImage(File image) async {
    try {
      final downloadUrl = "https://example.com/path/to/uploaded/image.jpg";

      final user = ref.read(authManagerProvider).user;
      if (user != null) {
        await ref.read(userServiceProvider).updateUserProfile(user.id, { // Changed from uid to id
          'profileImageUrl': downloadUrl,
        });

        ref.read(profileImageProvider.notifier).state = image;

        setState(() {
          _profileImageUrl = downloadUrl;
        });

        log("Profile image updated successfully.");
      }
    } catch (e) {
      log("Error uploading profile image: $e");
    }
  }

  Future<void> _deleteProfileImage() async {
    try {
      final user = ref.read(authManagerProvider).user;
      if (user != null) {
        // Update profile with null image URL
        await ref.read(userServiceProvider).updateUserProfile(user.id, {
          'profileImageUrl': null,
        });

        setState(() {
          _profileImageUrl = null;
        });

        log("Profile image deleted successfully.");
      }
    } catch (e) {
      log("Error deleting profile image: $e");
      CustomPopup.show(
        context: context,
        title: 'Error',
        message: 'Failed to delete profile image. Please try again.',
        buttonText: 'OK',
        imagePath: 'public/assets/images/Alert.png',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final verticalSpacing = screenWidth * 0.03;
    final userDocAsyncValue = ref.watch(userDocumentProvider);

    return Scaffold(
      body: SafeArea(
        child: userDocAsyncValue.when(
          loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFA51414))),
          error: (err, stack) {
            log("Error loading user document: $err");
            return Center(child: Text('Error loading profile: $err'));
          },
          data: (userDoc) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _populateControllers(userDoc);
                });
              }
            });

            return SingleChildScrollView(
              padding: EdgeInsets.only(
  left: screenWidth * 0.05,
  right: screenWidth * 0.05,
  bottom: verticalSpacing,
  // top: 0, // removed top padding
),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ProfilePicture(
                      initialImageUrl: _profileImageUrl,
                      onImageSelected: (File image) {
                        _uploadProfileImage(image);
                      },
                      onImageDeleted: () {
                        _deleteProfileImage();
                      },
                    ),
                  ),
                  SizedBox(height: verticalSpacing * 0.8),
                  Row(
                    children: [
                      Expanded(
                        child: RedButton(
                          label: 'Change Password',
                          height: screenWidth * 0.095,
                          width: screenWidth * 0.4,
                          onPressed: _sendResetLink,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Expanded(
                        child: RedButton(
                          label: 'Logout',
                          height: screenWidth * 0.095,
                          width: screenWidth * 0.4,
                          onPressed: _handleLogout,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: verticalSpacing * 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'User Information',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.black,
                        ),
                      ),
                      _isSaving
                          ? const SizedBox(
                              width: 30,
                              height: 30,
                              child: Center(child: CircularProgressIndicator(strokeWidth: 3, color: Color(0xFFA51414))))
                          : IconButton(
                              icon: Icon(
                                isEditing ? Icons.check : Icons.edit,
                                color: const Color(0xFFA51414),
                                size: screenWidth * 0.07,
                              ),
                              onPressed: () {
                                if (isEditing) {
                                  _updateUserProfile();
                                } else {
                                  setState(() {
                                    isEditing = true;
                                  });
                                }
                              },
                            ),
                    ],
                  ),
                  SizedBox(height: verticalSpacing*0.1),
                  CustomTextField(controller: _firstNameController, label: 'First Name', height: screenWidth * 0.13, readOnly: !isEditing),
                  SizedBox(height: verticalSpacing),
                  CustomTextField(controller: _lastNameController, label: 'Last Name', height: screenWidth * 0.13, readOnly: !isEditing),
                  SizedBox(height: verticalSpacing),
                  CustomTextField(controller: _companyNameController, label: 'Company Name', height: screenWidth * 0.13, readOnly: !isEditing),
                  SizedBox(height: verticalSpacing),
                  CustomTextField(controller: _emailController, label: 'Your Email', height: screenWidth * 0.13, readOnly: true),
                  SizedBox(height: verticalSpacing),
                  Row(
                    children: [
                      Expanded(child: CustomTextField(controller: _phoneController, label: 'Phone Number', height: screenWidth * 0.13, readOnly: !isEditing, keyboardType: TextInputType.phone)),
                      SizedBox(width: screenWidth * 0.03),
                      Expanded(child: CustomTextField(controller: _altPhoneController, label: 'Alternate No.', height: screenWidth * 0.13, readOnly: !isEditing, keyboardType: TextInputType.phone)),
                    ],
                  ),
                  SizedBox(height: verticalSpacing),
                  CustomTextField(controller: _gstinController, label: 'GSTIN NO', height: screenWidth * 0.13, readOnly: !isEditing),
                  SizedBox(height: verticalSpacing),
                  Row(
                    children: [
                      Expanded(child: CustomTextField(controller: _typeController, label: 'Type', height: screenWidth * 0.13, readOnly: !isEditing)),
                      SizedBox(width: screenWidth * 0.03),
                      Expanded(child: CustomTextField(controller: _sourceController, label: 'Source', height: screenWidth * 0.13, readOnly: !isEditing)),
                    ],
                  ),
                  SizedBox(height: verticalSpacing * 1.5),
                  Row(
                    children: [
                      const Expanded(child: Text("Send Order Update Emails", style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Color(0xFFA51414)))),
                      Expanded(
                        child: TwoRadioButtons(
                          forceHorizontalLayout: true,
                          options: const ['Yes', 'No'],
                          key: ValueKey(_sendEmails),
                          initialSelection: _sendEmails ? 0 : 1,
                          onSelectionChanged: isEditing
                              ? (value) {
                                  setState(() {
                                    _sendEmails = (value == 0);
                                  });
                                }
                              : (value) {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
