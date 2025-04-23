import 'package:Semikart/Components/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Semikart/managers/auth_manager.dart';
import '../common/signinwith_google.dart';
import 'horizontal_radios.dart';
import 'custom_text_field.dart';
import 'password_text_field.dart';
import '../common/forgot_password.dart';
import '../common/red_button.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import '../../base_scaffold.dart';
import '../../managers/auth_manager.dart';
// Removed import for BaseScaffold as navigation is handled by AuthWrapper

// --- Changed to ConsumerStatefulWidget ---
class LoginPasswordNewScreen extends ConsumerStatefulWidget {
  const LoginPasswordNewScreen({super.key});

  @override
  // --- Changed to ConsumerState ---
  ConsumerState<LoginPasswordNewScreen> createState() => _LoginPasswordNewScreenState();
}

// --- Changed to ConsumerState ---
class _LoginPasswordNewScreenState extends ConsumerState<LoginPasswordNewScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; // To show a loading indicator

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- Updated Login Logic Function ---
  Future<void> _login() async {
    // Hide keyboard if it's open
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // --- Use AuthManager via Riverpod ---
    final authManager = ref.read(authManagerProvider.notifier);
    final success = await authManager.login(email, password);

    // Check if the widget is still mounted before updating state
    if (!mounted) return;

    setState(() {
      _isLoading = false; // Hide loading indicator
    });

    // --- Navigation is handled by AuthWrapper based on AuthState ---
    // No explicit Navigator.pushReplacement needed here anymore.

   if(!success) {
      // Show error message if login failed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please check your credentials.'),
          backgroundColor: Color(0xFFA51414), // Red color for error
          duration: Duration(seconds: 3),
        ),
      );
    }
    // If login was successful, AuthWrapper will automatically rebuild and show BaseScaffold
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.08),
                Image.asset(
                  'public/assets/images/semikart_logo_medium.png',
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.05,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
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
                SizedBox(height: screenHeight * 0.02),
                Center( // Removed const
                  child: HorizontalRadios(
                    initialOption: "password",
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomTextField(
                  controller: _emailController,
                  label: "Email",
                  height: screenHeight * 0.06,
                ),
                SizedBox(height: screenHeight * 0.04),
                PasswordTextField(
                  controller: _passwordController,
                  label: "Password",
                  height: screenHeight * 0.06,
                ),
                SizedBox(height: screenHeight * 0.04),
                Align(
                  alignment: Alignment.centerRight,
                  child: ForgotPasswordButton(
                    label: "Forgot Password?",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
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
                SizedBox(height: screenHeight * 0.05),
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Color(0xFFA51414))
                      : RedButton(
                          label: "Login",
                          width: screenWidth * 0.90,
                          height: screenHeight * 0.06,
                          // *** Call the _login function ***
                          onPressed: _login,
                          // *** REMOVED Navigator.pushReplacement ***
                        ),
                ),
                 SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}