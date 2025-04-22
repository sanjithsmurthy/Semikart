import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:Semikart/managers/auth_manager.dart'; // Import AuthManager
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import 'horizontal_radios.dart'; // Import the HorizontalRadios widget
import 'custom_text_field.dart'; // Import the CustomTextField widget
import '../common/forgot_password.dart';
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/inactive_red_button.dart'; // Import the InactiveButton widget
import 'login_password.dart'; // Import the LoginPassword screen
import 'signup_screen.dart'; // Import the SignUpScreen
import '../common/popup.dart'; // Import the CustomPopup widget

// --- Changed to ConsumerStatefulWidget ---
class LoginOTPScreen extends ConsumerStatefulWidget {
  const LoginOTPScreen({super.key}); // Added super.key

  @override
  // --- Changed to ConsumerState ---
  _LoginOTPScreenState createState() => _LoginOTPScreenState();
}

// --- Changed to ConsumerState ---
class _LoginOTPScreenState extends ConsumerState<LoginOTPScreen> {
  bool canSendOTP = false; // Initially, the Generate OTP button is inactive
  int countdown = 0; // Countdown timer in seconds
  Timer? timer;
  bool _isLoading = false; // Loading state for login button

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController(); // Controller for OTP input
  bool isEmailValid = false; // State to track email validity

  // Temporary database of email IDs (Replace with actual validation)
  final List<String> emailDatabase = [
    "test1@example.com",
    "user2@example.com",
    "admin@example.com",
    "demo@example.com"
  ];

  // Hardcoded OTP for simulation (Replace with actual OTP verification)
  final String correctOTP = "123456";

  // Validate email against the temporary database
  void _validateEmail(String email) {
    setState(() {
      // Basic email format check (optional but recommended)
      bool isValidFormat = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
      // Check if email exists in the database (replace with API call)
      isEmailValid = isValidFormat && emailDatabase.contains(email);
      // Enable Generate OTP button only if email is valid and timer is not running
      canSendOTP = isEmailValid && countdown == 0;
    });
  }

  // Start the OTP resend timer
  void _startTimer() {
    setState(() {
      canSendOTP = false; // Disable OTP generation while the timer is running
      countdown = 90; // Reset the timer to 1:30 (90 seconds)
    });

    timer?.cancel(); // Cancel any existing timer
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) { // Check if widget is still mounted
        timer.cancel();
        return;
      }
      setState(() {
        if (countdown > 0) {
          countdown--; // Decrement the timer
        } else {
          timer.cancel(); // Stop the timer
          // Enable OTP generation only if email is still valid
          canSendOTP = isEmailValid;
        }
      });
    });
  }

  // --- Login with OTP Logic ---
  Future<void> _loginWithOtp() async {
    FocusScope.of(context).unfocus(); // Hide keyboard

    final enteredOtp = _otpController.text.trim();
    final email = _emailController.text.trim();

    // Basic validation
    if (email.isEmpty || enteredOtp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and OTP.')),
      );
      return;
    }

    // --- Simulate OTP Verification ---
    if (enteredOtp == correctOTP) {
      setState(() { _isLoading = true; });

      // --- Simulate successful login using AuthManager ---
      // In a real app, you might have a specific loginWithOtp method
      // or verify the OTP server-side and then call login if successful.
      // Here, we simulate by calling the standard login method.
      // We pass a dummy password as it's required by the current login method signature.
      final authManager = ref.read(authManagerProvider.notifier);
      final success = await authManager.login(email, "dummy_password_for_otp");

      if (!mounted) return;
      setState(() { _isLoading = false; });

      // AuthWrapper handles navigation on success. Show error if login simulation failed.
      if (!success) {
         ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
             content: Text('Login failed after OTP verification. Please try again.'),
             backgroundColor: Color(0xFFA51414),
           ),
         );
      }
      // On success, AuthWrapper will navigate to BaseScaffold

    } else {
      // --- Incorrect OTP ---
      if (!mounted) return;
      // Show popup using CustomPopup
      await CustomPopup.show(
        context: context,
        title: 'Invalid OTP',
        message: "The OTP you entered is incorrect. Please try again.",
        buttonText: 'OK',
        imagePath: 'public/assets/images/Alert.png', // Optional image path
      );
    }
  }


  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Determine if login button should be active
    final bool canLogin = _emailController.text.isNotEmpty && _otpController.text.isNotEmpty && !_isLoading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding( // Use Padding instead of Positioned for simpler layout
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.08),
                // Semikart Logo
                Image.asset(
                  'public/assets/images/semikart_logo_medium.png',
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.05,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.05), // Adjust spacing

                // Login Text
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Adjust spacing

                // Google Sign-In Button
                Center(
                  child: SignInWithGoogleButton(
                    onPressed: () {
                      print('Google Sign-In button pressed');
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Google Sign-In not implemented yet.')),
                      );
                    },
                    isLoading: false,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Adjust spacing

                // Horizontal Radios
                Center(
                  child: HorizontalRadios(
                    initialOption: "otp", // Set the initial selected option to OTP
                  ),
                ),
                SizedBox(height: screenHeight * 0.04), // Adjust spacing

                // Email Input Field
                CustomTextField(
                  controller: _emailController,
                  label: "Email",
                  // keyboardType: TextInputType.emailAddress, // CustomTextField might not support this directly
                  onChanged: _validateEmail, // Validate email on input change
                ),
                SizedBox(height: screenHeight * 0.03), // Adjust spacing

                // OTP Input Field Row (Input + Generate/Timer)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
                  children: [
                    // OTP Input Field (Takes remaining space)
                    Expanded(
                      child: CustomTextField(
                        controller: _otpController,
                        label: "OTP",
                        // keyboardType: TextInputType.number, // CustomTextField might not support this directly
                        onChanged: (_) => setState(() {}), // Trigger rebuild to check login button state
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03), // Spacing between field and button/timer
                    // Generate OTP Button or Timer
                    Container(
                      height: screenHeight * 0.065, // Match approx height of text field
                      alignment: Alignment.center, // Center button/timer vertically
                      child: canSendOTP
                          ? SizedBox( // Use SizedBox to constrain button width if needed
                              width: screenWidth * 0.3, // Example width
                              child: RedButton(
                                label: "Get OTP",
                                height: 45, // Adjust height as needed
                                isWhiteButton: true, // Make it look different?
                                onPressed: () {
                                  // TODO: Add logic to actually send OTP via API
                                  print("Requesting OTP for ${_emailController.text}");
                                  _startTimer(); // Start the timer after requesting
                                },
                              ),
                            )
                          : (countdown > 0) // Show timer only if countdown is active
                              ? Text(
                                  "${countdown ~/ 60}:${(countdown % 60).toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.038,
                                    color: const Color(0xFFA51414),
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : SizedBox(width: screenWidth * 0.3), // Placeholder to maintain layout when no button/timer
                    ),
                  ],
                ),
                 SizedBox(height: screenHeight * 0.02), // Adjust spacing

                // "Don't have an account?" Button
                Align(
                  alignment: Alignment.centerRight,
                  child: ForgotPasswordButton(
                    label: "Don't have an account?",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // Adjust spacing

                // Login Button
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Color(0xFFA51414))
                      : canLogin
                          ? RedButton(
                              label: "Login",
                              width: screenWidth * 0.90,
                              height: screenHeight * 0.06,
                              onPressed: _loginWithOtp, // Call the OTP login function
                              // --- REMOVED Navigator.pushReplacement ---
                            )
                          : InactiveButton(
                              label: "Login",
                              width: screenWidth * 0.90,
                              height: screenHeight * 0.06,
                            ),
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 30), // Keyboard padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}