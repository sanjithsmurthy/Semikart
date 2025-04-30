import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For status bar customization
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:Semikart/managers/auth_manager.dart'; // Import AuthManager
import 'custom_text_field.dart'; // Import the CustomTextField widget
import '../common/red_button.dart'; // Import the RedButton widget

// Convert to ConsumerStatefulWidget
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key}); // Add key to constructor

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController(); // Controller for email input
  bool _isLoading = false; // Loading state

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    FocusScope.of(context).unfocus();
    if (_isLoading || emailController.text.trim().isEmpty) return;

    setState(() { _isLoading = true; });

    final email = emailController.text.trim();
    final authManager = ref.read(authManagerProvider.notifier);
    final success = await authManager.sendPasswordReset(email);

    if (!mounted) return; // Check if widget is still mounted

    setState(() { _isLoading = false; });

    // Show feedback via Snackbar (AuthWrapper also shows errors)
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset link sent to $email.'),
          backgroundColor: Colors.green,
        ),
      );
      // Optionally navigate back after a delay or show a success message screen
      // Navigator.pop(context);
    } else {
      // Error message is typically shown by the AuthWrapper listener
      // but you could show a specific one here if needed.
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Failed to send reset link. Please check the email and try again.'),
      //     backgroundColor: Colors.redAccent,
      //   ),
      // );
    }
  }


  @override
  Widget build(BuildContext context) {
    // ... (Keep SystemChrome and screen dimension calculations) ...
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double titleTop = 0.15;
    final double instructionTop = 0.22;
    final double emailInputTop = 0.32;
    final double buttonTop = 0.42;

    // Watch auth state to potentially disable elements during other auth operations
    final authState = ref.watch(authManagerProvider);
    final isAuthenticating = authState.status == AuthStatus.unknown || _isLoading;


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight * (buttonTop + 0.15),
            width: screenWidth,
            child: Stack(
              children: [
                // --- Positioned Forgot Password Title ---
                Positioned(
                  left: screenWidth * 0.05,
                  top: screenHeight * titleTop,
                  child: Text(
                    'Forgot Password', // Add text
                    style: TextStyle(
                      fontSize: screenWidth * 0.055,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                // --- Positioned Instruction Text ---
                Positioned(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * instructionTop,
                  child: Text(
                    'Enter the email address associated with your account and we\'ll send you a link to reset your password.', // Add text
                     style: TextStyle(
                       fontSize: screenWidth * 0.038,
                       color: Colors.grey[700],
                     ),
                    textAlign: TextAlign.left,
                  ),
                ),

                // --- Positioned Email Input Field ---
                Positioned(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * emailInputTop,
                  child: CustomTextField(
                    controller: emailController, // Provide controller
                    label: "Email", // Provide label
                    height: screenHeight * 0.06, // Keep height if needed
                  ),
                ),

                // --- Positioned Send Reset Link Button ---
                Positioned(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * buttonTop,
                  child: isAuthenticating
                      ? Center(child: CircularProgressIndicator(color: Color(0xFFA51414)))
                      : RedButton(
                          label: "Send Reset Link",
                          width: screenWidth * 0.9, // Ensure button spans width
                          height: screenHeight * 0.06,
                          onPressed: _sendResetLink, // Call the Firebase reset function
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}