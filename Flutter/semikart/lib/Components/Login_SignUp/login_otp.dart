import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:Semikart/managers/auth_manager.dart'; // Import AuthManager
import '../common/signinwith_google.dart';
import 'horizontal_radios.dart';
import 'custom_text_field.dart';
import '../common/forgot_password.dart';
import '../common/red_button.dart';
import '../common/inactive_red_button.dart';
import 'login_password.dart';
import 'signup_screen.dart';
import '../common/popup.dart';
// import 'package:Semikart/services/google_auth_service.dart'; // Removed deprecated service

// Convert to ConsumerStatefulWidget
class LoginOTPScreen extends ConsumerStatefulWidget {
  @override
  _LoginOTPScreenState createState() => _LoginOTPScreenState();
}

// Convert to ConsumerState
class _LoginOTPScreenState extends ConsumerState<LoginOTPScreen> {
  bool canSendOTP = false;
  int countdown = 0;
  Timer? timer;
  bool _isLoading = false; // Added loading state

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  // bool isEmailValid = false; // TODO: Remove - Firebase handles validation

  // TODO: Remove - This is temporary and should be replaced with Firebase logic
  final List<String> emailDatabase = [
    "test1@example.com",
    "user2@example.com",
    "admin@example.com",
    "demo@example.com"
  ];

  // TODO: Remove - OTP should be verified via Firebase
  final String correctOTP = "123456";

  // TODO: Refactor - Replace with Firebase phone/email verification trigger
  void _validateEmail(String email) {
    setState(() {
      // isEmailValid = emailDatabase.contains(email);
      // canSendOTP = isEmailValid;
      // For now, enable OTP if email field is not empty (placeholder)
      canSendOTP = email.isNotEmpty;
    });
  }

  // TODO: Refactor - Timer logic might change based on Firebase flow
  void _startTimer() {
    setState(() {
      canSendOTP = false;
      countdown = 90;
    });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) { // Check if widget is still mounted
        timer.cancel();
        return;
      }
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
          // canSendOTP = isEmailValid; // Re-enable based on validation
          // For now, re-enable if email is not empty (placeholder)
          canSendOTP = _emailController.text.isNotEmpty;
        }
      });
    });
  }

  // --- Google Sign-In using AuthManager ---
  Future<void> _googleSignIn() async {
     FocusScope.of(context).unfocus();
     if (_isLoading) return;

     setState(() { _isLoading = true; });

     final authManager = ref.read(authManagerProvider.notifier);
     await authManager.googleSignIn(); // Call AuthManager method

     if (!mounted) return;
     setState(() { _isLoading = false; });
     // Navigation and errors handled by AuthWrapper
  }


  @override
  void dispose() {
    timer?.cancel();
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Watch auth state for loading indicators
    final authState = ref.watch(authManagerProvider);
    final isAuthenticating = authState.status == AuthStatus.unknown || _isLoading;


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Stack(
              children: [
                // ... (Logo, Login text - unchanged) ...
                 Positioned(
                  left: screenWidth * 0.05, // 5% of screen width
                  top: screenHeight * 0.08, // 8% of screen height
                  child: Image.asset(
                    'public/assets/images/semikart_logo_medium.png', // Path to the logo
                    width: screenWidth * 0.4, // 40% of screen width
                    height: screenHeight * 0.05, // 5% of screen height
                    fit: BoxFit.contain, // Ensure the image fits within the dimensions
                  ),
                ),

                // Positioned Login text
                Positioned(
                  left: screenWidth * 0.05, // 5% of screen width
                  top: screenHeight * 0.18, // 18% of screen height
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: screenWidth * 0.055, // 5.5% of screen width
                       // Product Sans font
                      color: Colors.black, // Black color
                      fontWeight: FontWeight.bold, // Bold weight
                    ),
                  ),
                ),


                // --- Updated SignInWithGoogleButton ---
                Positioned(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * 0.23,
                  child: Center(
                    child: SignInWithGoogleButton(
                      onPressed: isAuthenticating ? null : _googleSignIn, // Use AuthManager method
                      isLoading: isAuthenticating, // Use combined loading state
                    ),
                  ),
                ),

                // --- HorizontalRadios ---
                Positioned(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * 0.33,
                  child: Center(
                    child: HorizontalRadios(
                      initialOption: "otp",
                      // TODO: Consider disabling radios during authentication if needed
                      // enabled: !isAuthenticating,
                    ),
                  ),
                ),

                // --- Email/Phone Input ---
                Positioned(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * 0.45,
                  child: IgnorePointer( // Wrap with IgnorePointer
                    ignoring: isAuthenticating, // Disable pointer events if authenticating
                    child: CustomTextField(
                      controller: _emailController,
                      label: "Email or Phone", // Adjust label
                      // enabled: !isAuthenticating, // Removed invalid parameter
                      onChanged: (value) {
                         _validateEmail(value); // Temporary validation trigger
                      },
                    ),
                  ),
                ),

                // --- OTP Section ---
                Positioned( // Wrap OTP section in Positioned
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * 0.55,
                  child: IgnorePointer( // Wrap with IgnorePointer
                    ignoring: isAuthenticating, // Disable pointer events if authenticating
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        CustomTextField(
                          controller: _otpController,
                          label: "OTP",
                          // enabled: !isAuthenticating, // Removed invalid parameter
                          // TODO: Add keyboardType property to CustomTextField if needed
                        ),
                      ],
                    ),
                  ),
                ), // End Positioned for OTP

                // --- Resend OTP Timer ---
                Positioned(
                  right: screenWidth * 0.09,
                  top: screenHeight * 0.65,
                  child: (canSendOTP || isAuthenticating) // Hide if OTP can be sent OR if authenticating
                      ? SizedBox.shrink()
                      : Text(
                          "Resend OTP in ${countdown ~/ 60}:${(countdown % 60).toString().padLeft(2, '0')}",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Color(0xFFA51414), // Red color
                          ),
                          textAlign: TextAlign.center,
                        ),
                ),

                // --- Generate OTP Button ---
                // TODO: Refactor onPressed to trigger Firebase email verification
                Positioned(
                  top: screenHeight * 0.78,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: (canSendOTP && !isAuthenticating) // Enable only if allowed and not authenticating
                        ? RedButton(
                            label: "Generate OTP",
                            width: screenWidth * 0.85,
                            height: screenHeight * 0.06,
                            onPressed: () {
                              _startTimer(); // Start the timer
                              print("TODO: Trigger Firebase OTP for ${_emailController.text}");
                              // TODO: Call authManager.verifyPhoneNumber(...) or similar
                            },
                          )
                        : InactiveButton(
                            label: "Generate OTP",
                            width: screenWidth * 0.85,
                            height: screenHeight * 0.06,
                          ),
                  ),
                ),

                // --- "Don't have an account?" Button ---
                Positioned(
                  right: screenWidth * 0.05,
                  top: screenHeight * 0.70,
                  child: ForgotPasswordButton(
                    label: "Don't have an account?",
                    onPressed: isAuthenticating ? () {} : () { // Provide empty function when disabled
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                  ),
                ),

                // --- Login Button ---
                // TODO: Refactor onPressed to verify OTP using Firebase
                Positioned(
                  top: screenHeight * 0.884,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: isAuthenticating
                      ? CircularProgressIndicator(color: Color(0xFFA51414))
                      : RedButton(
                          label: "Login",
                          width: screenWidth * 0.85,
                          height: screenHeight * 0.06,
                          onPressed: () async {
                            if (isAuthenticating) return; // Prevent action if already loading

                            final otp = _otpController.text.trim();
                            if (otp.isEmpty) {
                               ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(content: Text('Please enter the OTP.')),
                               );
                               return;
                            }

                            print("TODO: Verify OTP $otp using Firebase");
                            // TODO: Set _isLoading = true
                            // TODO: Call authManager.signInWithPhoneCredential(...) or similar
                            // TODO: Set _isLoading = false

                            // --- Temporary Hardcoded Check (Remove) ---
                            if (otp == correctOTP) {
                              print("Login successful (using hardcoded OTP)");
                              // AuthWrapper will handle navigation on successful Firebase sign-in
                            } else {
                              // Error should be set in AuthManager state, AuthWrapper shows Snackbar
                              print("Invalid OTP (using hardcoded OTP)");
                               await CustomPopup.show( // Keep popup for now until full refactor
                                context: context,
                                title: 'Invalid OTP',
                                message: "The OTP you entered is incorrect. Please try again.",
                                buttonText: 'OK',
                                imagePath: 'public/assets/images/Alert.png',
                              );
                            }
                            // --- End Temporary Check ---
                          },
                        ),
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