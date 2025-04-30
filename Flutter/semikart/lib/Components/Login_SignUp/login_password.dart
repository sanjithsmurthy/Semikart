import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Semikart/managers/auth_manager.dart'; // Use the new AuthManager
import '../common/signinwith_google.dart';
import 'horizontal_radios.dart';
import 'custom_text_field.dart';
import 'password_text_field.dart';
import '../common/forgot_password.dart';
import '../common/red_button.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginPasswordNewScreen extends ConsumerStatefulWidget {
  const LoginPasswordNewScreen({super.key});

  @override
  ConsumerState<LoginPasswordNewScreen> createState() => _LoginPasswordNewScreenState();
}

class _LoginPasswordNewScreenState extends ConsumerState<LoginPasswordNewScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; // Local loading state for button feedback

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();
    if (_isLoading) return; // Prevent multiple clicks

    setState(() { _isLoading = true; });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Use AuthManager via Riverpod
    final authManager = ref.read(authManagerProvider.notifier);
    /*final success =*/ await authManager.login(email, password); // Removed unused success variable

    // Check if the widget is still mounted before updating state
    if (!mounted) return;

    setState(() { _isLoading = false; });

    // Navigation is handled by AuthWrapper based on AuthState changes.
    // Error messages are shown via the listener in AuthWrapper.
    // if (!success) {
    //   // Error Snackbar is now shown by AuthWrapper's listener
    // }
  }

  Future<void> _googleSignIn() async {
     FocusScope.of(context).unfocus();
     if (_isLoading) return;

     setState(() { _isLoading = true; });

     final authManager = ref.read(authManagerProvider.notifier);
     await authManager.googleSignIn(); // Call Google Sign-In method

     if (!mounted) return;
     setState(() { _isLoading = false; });
     // Navigation and errors handled by AuthWrapper
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Watch the auth state to disable buttons while authenticating elsewhere (e.g., Google)
    final authState = ref.watch(authManagerProvider);
    final isAuthenticating = authState.status == AuthStatus.unknown || _isLoading;


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.08),
                // --- Restored Image.asset ---
                Image.asset(
                  'public/assets/images/semikart_logo_medium.png', // Added asset path
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.05,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.05),
                // --- Restored Text ---
                Text(
                  'Login', // Added text content
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // --- Restored Center with SignInWithGoogleButton ---
                Center(
                  child: SignInWithGoogleButton(
                    onPressed: isAuthenticating ? null : () => _googleSignIn(), // Wrapped in non-async closure
                    isLoading: isAuthenticating,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // --- Restored Center with HorizontalRadios ---
                Center(
                  child: HorizontalRadios(
                    initialOption: "password",
                    // enabled: !isAuthenticating, // Optional: disable if needed
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                // --- Restored CustomTextField for Email ---
                CustomTextField(
                  controller: _emailController,
                  label: "Email",
                  height: screenHeight * 0.06,
                  // enabled: !isAuthenticating, // Removed undefined parameter
                ),
                SizedBox(height: screenHeight * 0.04),
                // --- Restored PasswordTextField ---
                PasswordTextField(
                  controller: _passwordController,
                  label: "Password",
                  height: screenHeight * 0.06,
                  // enabled: !isAuthenticating, // Removed undefined parameter
                ),
                SizedBox(height: screenHeight * 0.04),
                // --- Restored Forgot Password Button ---
                Align(
                  alignment: Alignment.centerRight,
                  child: ForgotPasswordButton(
                    label: "Forgot Password?",
                    onPressed: isAuthenticating ? () {} : () { // Provide empty function when authenticating
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                // --- Restored "Don't have an account?" Button ---
                Align(
                  alignment: Alignment.centerRight,
                  child: ForgotPasswordButton(
                    label: "Don't have an account?",
                    onPressed: isAuthenticating ? () {} : () { // Provide empty function when authenticating
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                // --- Restored Login Button ---
                Center(
                  child: isAuthenticating
                      ? const CircularProgressIndicator(color: Color(0xFFA51414))
                      : RedButton(
                          label: "Login",
                          width: screenWidth * 0.90,
                          height: screenHeight * 0.06,
                          onPressed: () => _login(), // Wrap async call in a closure
                        ),
                ),
                 SizedBox(height: screenHeight * 0.05), // Final padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}