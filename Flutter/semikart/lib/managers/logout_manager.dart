// filepath: d:\Semikart\Flutter\semikart\lib\managers\logout_manager.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Semikart/Components/common/popup.dart';
import 'package:Semikart/managers/auth_manager.dart'; // Ensure this import is present

class LogoutManager {
  final WidgetRef ref;

  LogoutManager(this.ref);

  /// Handles the user logout flow: shows confirmation, calls logout, and navigates to root.
  ///
  /// Requires the current [context] to show the dialog and navigate,
  /// and a [ref] to access the AuthManager.
  Future<void> handleLogout(BuildContext context) async {
    // Store the navigator state associated with the context *before* the async gap.
    final navigator = Navigator.of(context);
    // Also get the root navigator state explicitly.
    final rootNavigator = Navigator.of(context, rootNavigator: true);

    final confirmed = await CustomPopup.show(
      context: context, // Use the passed context for the dialog
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      buttonText: 'Confirm',
      cancelButtonText: 'Cancel',
      imagePath: 'public/assets/images/Alert.png', // Ensure this path is correct
    );

    if (confirmed == true) {
      // Perform the logout action using the provided ref
      await ref.read(authManagerProvider.notifier).logout();

      // Check if the original widget's context is still mounted before navigating.
      // Use the rootNavigator instance we captured earlier.
      if (navigator.context.mounted) {
         rootNavigator.pushNamedAndRemoveUntil('/', (route) => false);
      }
    }
  }
}