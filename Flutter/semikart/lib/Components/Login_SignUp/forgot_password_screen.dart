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
          backgroundColor: Color(0xFFA51414),
          duration: Duration(seconds: 3),
        ),
      );
      // Navigate back to the login screen after showing the snackbar
      Navigator.pop(context); 
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
    // Removed unused position variables

    // Watch auth state to potentially disable elements during other auth operations
    final authState = ref.watch(authManagerProvider);
    final isAuthenticating = authState.status == AuthStatus.unknown || _isLoading;


    return Scaffold( // Wrap with Scaffold
      backgroundColor: Colors.white,
      appBar: AppBar( // Add AppBar
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFFA51414)), // Back icon
          onPressed: () => Navigator.of(context).pop(), // Navigate back
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding( // Use Padding instead of SizedBox + Stack
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column( // Use Column for layout
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: screenHeight * 0.05), // Adjust spacing as needed

                // --- Forgot Password Title ---
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Spacing

                // --- Instruction Text ---
                Text(
                  'Enter the email address associated with your account and we\'ll send you a link to reset your password.',
                   style: TextStyle(
                     fontSize: screenWidth * 0.038,
                     color: Colors.grey[700],
                   ),
                ),
                SizedBox(height: screenHeight * 0.05), // Spacing

                // --- Email Input Field ---
                CustomTextField(
                  controller: emailController,
                  label: "Email",
                  height: screenHeight * 0.06,
                  keyboardType: TextInputType.emailAddress, // Set keyboard type
                ),
                SizedBox(height: screenHeight * 0.05), // Spacing

                // --- Send Reset Link Button ---
                Center( // Center the button
                  child: isAuthenticating
                      ? const CircularProgressIndicator(color: Color(0xFFA51414))
                      : RedButton(
                          label: "Send Reset Link",
                          width: screenWidth * 0.9, // Ensure button spans width
                          height: screenHeight * 0.06,
                          onPressed: _sendResetLink,
                        ),
                ),
                 SizedBox(height: screenHeight * 0.05), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}