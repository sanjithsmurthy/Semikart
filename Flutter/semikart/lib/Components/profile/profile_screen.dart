import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/popup.dart';
import '../../managers/auth_manager.dart';
import '../../services/user_service.dart' show userServiceProvider, userDocumentProvider, DocumentData;
import 'profilepic.dart';
import '../common/red_button.dart';
import '../Login_SignUp/custom_text_field.dart';
import '../common/two_radios.dart';
import '../../providers/profile_image_provider.dart';
import '../../models/user_profile.dart';
import 'dart:developer'; // For logging
import 'package:shared_preferences/shared_preferences.dart';

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

  UserProfile? _apiProfile;
  bool _apiProfileLoading = false;
  String? _apiProfileError;

  @override
  void initState() {
    super.initState();
    isEditing = false; // Always start in view mode
    _fetchAndSetApiProfile();
  }

  Future<void> _fetchAndSetApiProfile() async {
    setState(() {
      _apiProfileLoading = true;
      _apiProfileError = null;
    });
    try {
      // Always get customerId from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final customerId = prefs.getInt('customerId');
      if (customerId == null) {
        setState(() {
          _apiProfileError = 'No customer ID found. Please log in again.';
          _apiProfileLoading = false;
        });
        return;
      }
      final apiService = ref.read(apiServiceProvider);
      final data = await apiService.fetchUserInfo(customerId);
      if (data != null) {
        setState(() {
          _apiProfile = UserProfile(
            firstName: data['firstName'] ?? '',
            lastName: data['lastName'] ?? '',
            companyName: data['companyName'] ?? '',
            email: data['email'] ?? '',
            mobileNo: data['mobileNo'] ?? '',
            userType: data['userType'] ?? '',
            customerId: data['customerId'] ?? 0,
          );
          _apiProfileLoading = false;
        });
      } else {
        setState(() {
          _apiProfileError = 'Failed to fetch user info.';
          _apiProfileLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _apiProfileError = 'Error: \\${e.toString()}';
        _apiProfileLoading = false;
      });
    }
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
    final prefs = await SharedPreferences.getInstance();
    final customerId = prefs.getInt('customerId');
    if (customerId == null) {
      CustomPopup.show(context: context, title: 'Error', message: 'No customer ID found. Please log in again.', buttonText: 'OK', imagePath: 'public/assets/images/Alert.png');
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final success = await ref.read(userServiceProvider).updateUserInfo(
        customerId: customerId,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        companyName: _companyNameController.text.trim(),
        mobileNo: _phoneController.text.trim(),
        googleProfilePic: _profileImageUrl,
      );
      if (success) {
        await _fetchAndSetApiProfile(); // Refresh profile info after update
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
      } else {
        CustomPopup.show(
          context: context,
          title: 'Error',
          message: 'Failed to update profile. Please try again.',
          buttonText: 'OK',
          imagePath: 'public/assets/images/Alert.png',
        );
      }
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
      // TODO: Upload image to your storage (e.g., Firebase Storage) and get the URL
      // For now, simulate upload and use a placeholder URL
      final downloadUrl = "https://example.com/path/to/uploaded/image.jpg";

      final prefs = await SharedPreferences.getInstance();
      final customerId = prefs.getInt('customerId');
      if (customerId == null) return;

      // Update backend with new profile pic URL
      await ref.read(userServiceProvider).updateUserInfo(
        customerId: customerId,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        companyName: _companyNameController.text.trim(),
        mobileNo: _phoneController.text.trim(),
        googleProfilePic: downloadUrl,
      );

      ref.read(profileImageProvider.notifier).state = image;

      setState(() {
        _profileImageUrl = downloadUrl;
      });

      log("Profile image updated successfully.");
    } catch (e) {
      log("Error uploading profile image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final verticalSpacing = screenWidth * 0.03;
    final userDocAsyncValue = ref.watch(userDocumentProvider);

    if (_apiProfileLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFFA51414)));
    }
    if (_apiProfileError != null) {
      return Center(child: Text('Error: $_apiProfileError'));
    }
    if (_apiProfile != null) {
      // Use _apiProfile to populate fields ONLY if not editing
      if (!isEditing) {
        _firstNameController.text = _apiProfile!.firstName;
        _lastNameController.text = _apiProfile!.lastName;
        _companyNameController.text = _apiProfile!.companyName;
        _emailController.text = _apiProfile!.email;
        _phoneController.text = _apiProfile!.mobileNo;
        _typeController.text = _apiProfile!.userType;
        // ...other fields as needed
      }
    }

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
                    ),
                  ),
                  SizedBox(height: verticalSpacing * 0.8),
                  Row(
                    children: [
                      Expanded(
                        child: RedButton(
                          label: 'Change Password',
                          height: screenWidth * 0.09,
                          width: screenWidth * 0.4,
                          onPressed: _sendResetLink,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Expanded(
                        child: RedButton(
                          label: 'Logout',
                          height: screenWidth * 0.09,
                          width: screenWidth * 0.4,
                          onPressed: _handleLogout,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: verticalSpacing * 0.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'User Information',
                        style: TextStyle(
                          fontSize: screenWidth * 0.034,
                          color: Colors.black,
                        ),
                      ),
                      _isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: Center(child: CircularProgressIndicator(strokeWidth: 3, color: Color(0xFFA51414))))
                          : IconButton(
                              icon: Icon(
                                isEditing ? Icons.check : Icons.edit,
                                color: const Color(0xFFA51414),
                                size: screenWidth * 0.05,
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
                  CustomTextField(controller: _firstNameController, label: 'First Name', height: screenWidth * 0.11, readOnly: !isEditing),
                  SizedBox(height: verticalSpacing),
                  CustomTextField(controller: _lastNameController, label: 'Last Name', height: screenWidth * 0.11, readOnly: !isEditing),
                  SizedBox(height: verticalSpacing),
                  CustomTextField(controller: _companyNameController, label: 'Company Name', height: screenWidth * 0.11, readOnly: !isEditing),
                  SizedBox(height: verticalSpacing),
                  CustomTextField(controller: _emailController, label: 'Your Email', height: screenWidth * 0.11, readOnly: true),
                  SizedBox(height: verticalSpacing),
                  Row(
                    children: [
                      Expanded(child: CustomTextField(controller: _phoneController, label: 'Phone Number', height: screenWidth * 0.11, readOnly: !isEditing, keyboardType: TextInputType.phone)),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(child: CustomTextField(controller: _altPhoneController, label: 'Alternate No.', height: screenWidth * 0.11, readOnly: !isEditing, keyboardType: TextInputType.phone)),
                    ],
                  ),
                  SizedBox(height: verticalSpacing),
                  CustomTextField(controller: _gstinController, label: 'GSTIN NO', height: screenWidth * 0.11, readOnly: !isEditing),
                  SizedBox(height: verticalSpacing),
                  Row(
                    children: [
                      Expanded(child: CustomTextField(controller: _typeController, label: 'Type', height: screenWidth * 0.11, readOnly: true)),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(child: CustomTextField(controller: _sourceController, label: 'Source', height: screenWidth * 0.11, readOnly: !isEditing)),
                    ],
                  ),
                  SizedBox(height: verticalSpacing * 1.5),
                  Row(
                    children: [
                      const Expanded(child: Text("Send Order Update Emails", style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xFFA51414)))),
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
