import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  // Removed _isLoading state variable
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
    // Data fetching is now handled by the StreamProvider in the build method
  }

  // Removed _fetchUserData method

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

  // _sendResetLink remains the same
  Future<void> _sendResetLink() async {
    // ...existing code...
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

  // _updateUserProfile remains the same, but add updatedAt timestamp
  Future<void> _updateUserProfile() async {
    // ...existing code...
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
      'altPhoneNumber': _altPhoneController.text.trim(), // Assuming field name
      'gstin': _gstinController.text.trim(), // Assuming field name
      'userType': _typeController.text.trim(), // Assuming field name
      'leadSource': _sourceController.text.trim(), // Assuming field name
      'sendOrderEmails': _sendEmails,
      // Add updatedAt timestamp for client-side updates too
      'updatedAt': FieldValue.serverTimestamp(),
    };

    try {
      final userService = ref.read(userServiceProvider);
      await userService.updateUserProfile(user.uid, dataToUpdate);
      CustomPopup.show(
        context: context,
        title: 'Success',
        message: 'Profile updated successfully!',
        buttonText: 'OK',
        imagePath: 'public/assets/images/checksucccess.png',
      );
      setState(() {
        isEditing = false;
        _controllersPopulated = true; // Ensure flag is set after successful save
      }); // Exit editing mode on success
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

  // _handleLogout remains the same
  Future<void> _handleLogout() async {
    // ...existing code...
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

  // Helper to populate controllers safely
  void _populateControllers(DocumentSnapshot<Map<String, dynamic>>? userDoc) {
     final authUser = ref.read(authManagerProvider).user;
     String? currentUserId = authUser?.uid;

     // Reset population flag if the user ID has changed (login/logout)
     if (_lastProcessedUserId != currentUserId) {
        _controllersPopulated = false;
        _lastProcessedUserId = currentUserId;
     }

     // Only populate if controllers haven't been populated for the current user yet
     if (!_controllersPopulated && currentUserId != null) {
        String firstName = '';
        String lastName = '';
        String companyName = '';
        String email = authUser?.email ?? ''; // Default to auth email
        String phone = '';
        String altPhone = '';
        String gstin = '';
        String type = '';
        String source = '';
        bool sendEmails = true; // Default
        String? imageUrl = authUser?.photoURL; // Default to auth photoURL

        if (userDoc != null && userDoc.exists) {
           final data = userDoc.data()!;
           firstName = data['firstName'] ?? '';
           lastName = data['lastName'] ?? '';
           companyName = data['companyName'] ?? '';
           email = data['email'] ?? email; // Prefer Firestore email if available
           phone = data['phoneNumber'] ?? '';
           altPhone = data['altPhoneNumber'] ?? '';
           gstin = data['gstin'] ?? '';
           type = data['userType'] ?? '';
           source = data['leadSource'] ?? '';
           sendEmails = data['sendOrderEmails'] ?? true;
           imageUrl = data['profileImageUrl'] as String? ?? imageUrl; // Prefer Firestore URL
        } else if (authUser?.displayName != null) {
           // Fallback to splitting displayName if Firestore doc doesn't exist yet
           List<String> nameParts = authUser!.displayName!.split(' ');
           if (nameParts.isNotEmpty) firstName = nameParts.first;
           if (nameParts.length > 1) lastName = nameParts.sublist(1).join(' ');
        }

        // Update controllers and state
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

        _controllersPopulated = true; // Mark as populated for this user ID

        // If doc didn't exist, start in editing mode
        if (userDoc == null || !userDoc.exists) {
           isEditing = true;
        }
     } else if (currentUserId == null) {
        // Clear controllers if logged out
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
        _controllersPopulated = false; // Reset flag
        _lastProcessedUserId = null;
     }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final verticalSpacing = screenWidth * 0.03;
    final userDocAsyncValue = ref.watch(userDocumentProvider); // Watch the stream

    return Scaffold(
      body: SafeArea(
        // Use AsyncValue.when to handle stream states
        child: userDocAsyncValue.when(
          loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFA51414))),
          error: (err, stack) {
             log("Error loading user document: $err");
             // Still try to build UI with potential fallback data if controllers were populated before error
             // Or show a dedicated error UI
             return Center(child: Text('Error loading profile: $err'));
          },
          data: (userDoc) {
            // Use a post-frame callback to populate controllers AFTER the build phase
            // This avoids calling setState during build and ensures context is available
            WidgetsBinding.instance.addPostFrameCallback((_) {
               if (mounted) {
                  setState(() {
                     _populateControllers(userDoc);
                  });
               }
            });

            // --- Build UI ---
            // This part uses the controller values which are populated by _populateControllers
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: verticalSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ProfilePicture(
                      initialImageUrl: _profileImageUrl,
                      onImageSelected: (File image) {
                        ref.read(profileImageProvider.notifier).state = image;
                        log("TODO: Upload image and update profileImageUrl in Firestore");
                        // Example:
                        // 1. Upload `image` -> get downloadUrl
                        // 2. final user = ref.read(authManagerProvider).user;
                        // 3. if (user != null) {
                        // 4.   ref.read(userServiceProvider).updateUserProfile(user.uid, {'profileImageUrl': downloadUrl});
                        // 5. }
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
                      _isSaving
                          ? const SizedBox(
                          width: 48, height: 48,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 3, color: Color(0xFFA51414)))
                      )
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
                  SizedBox(height: verticalSpacing),
                  // --- Text Fields ---
                  CustomTextField(controller: _firstNameController, label: 'First Name', height: screenWidth * 0.13, readOnly: !isEditing),
                  SizedBox(height: verticalSpacing),
                  CustomTextField(controller: _lastNameController, label: 'Last Name', height: screenWidth * 0.13, readOnly: !isEditing),
                  SizedBox(height: verticalSpacing),
                  CustomTextField(controller: _companyNameController, label: 'Company Name', height: screenWidth * 0.13, readOnly: !isEditing),
                  SizedBox(height: verticalSpacing),
                  CustomTextField(controller: _emailController, label: 'Your Email', height: screenWidth * 0.13, readOnly: true), // Email always read-only
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
                  // --- Radio Buttons ---
                  Row(
                    children: [
                      const Expanded(child: Text("Send Order Update Emails", style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Color(0xFFA51414)))),
                      Expanded(
                        child: TwoRadioButtons(
                          forceHorizontalLayout: true,
                          options: const ['Yes', 'No'],
                          // Use a Key based on the value to force rebuild when _sendEmails changes
                          key: ValueKey(_sendEmails),
                          initialSelection: _sendEmails ? 0 : 1,
                          onSelectionChanged: isEditing
                              ? (value) { setState(() { _sendEmails = (value == 0); }); }
                              : (value) {}, // Provide an empty function when not editing
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
