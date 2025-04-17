import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this package
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpodmport BaseScaffold
import 'package:Semikart/managers/auth_manager.dart'; // Import AuthManager provider
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import 'horizontal_radios.dart'; // Import the HorizontalRadios widget
import 'custom_text_field.dart'; // Import the CustomTextField widget
import 'password_text_field.dart'; // Import the PasswordTextField widget
import '../common/forgot_password.dart'; // Import the ForgotPasswordButton widget
import '../common/red_button.dart'; // Import the RedButton widget
import 'signup_screen.dart'; // Import the SignUpScreen widget
import 'forgot_password_screen.dart'; // Import the ForgotPassword screen

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
    // Use ref.read to access the notifier and call the login method
    final authManager = ref.read(authManagerProvider.notifier);
    final success = await authManager.login(email, password);

    // Check if the widget is still mounted before updating state
    if (!mounted) return;

    setState(() {
      _isLoading = false; // Hide loading indicator
    });

    // --- Navigation is handled by AuthWrapper based on AuthState ---
    // No explicit Navigator.pushReplacement needed here anymore.

    if (!success) {
      // Show error message if login failed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2), // Show for a short duration
        ),
      );
    }
    // --- End of Authentication Logic ---
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Watch the auth state to potentially show errors differently if needed
    // final authState = ref.watch(authManagerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Use Padding instead of SizedBox + Stack for better layout handling with keyboard
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Horizontal padding
            child: Column( // Use Column for vertical layout
              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
              children: [
                SizedBox(height: screenHeight * 0.08), // Top spacing
                // Semikart logo
                Image.asset(
                  'public/assets/images/semikart_logo_medium.png', // Path to the logo
                  width: screenWidth * 0.4, // 40% of screen width
                  height: screenHeight * 0.05, // 5% of screen height
                  fit: BoxFit.contain, // Ensure the image fits within the dimensions
                ),
                SizedBox(height: screenHeight * 0.05), // Spacing after logo

                // Login text
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: screenWidth * 0.055, // 5.5% of screen width
                    color: Colors.black, // Black color
                    fontWeight: FontWeight.bold, // Bold weight
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Spacing after Login text

                // SignInWithGoogleButton
                Center( // Keep Google button centered if desired
                  child: SignInWithGoogleButton(
                    onPressed: () {
                      // TODO: Handle the Google sign-in logic here
                      print('Google Sign-In button pressed');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Google Sign-In not implemented yet.')),
                      );
                    },
                    isLoading: false, // Set to true if loading state is required
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Spacing after Google button

                // HorizontalRadios
                Center( // Keep radios centered
                  child: HorizontalRadios(
                    initialOption: "password", // Set the initial selected option
                  ),
                ),
                SizedBox(height: screenHeight * 0.04), // Spacing after radios

                // CustomTextField for Email
                CustomTextField(
                  controller: _emailController, // Use the controller
                  label: "Email", // Set the label to "Email"
                  height: screenHeight * 0.06, // 6% of screen height
                ),
                SizedBox(height: screenHeight * 0.04), // Spacing after email field

                // PasswordTextField for Password
                PasswordTextField(
                  controller: _passwordController, // Use the controller
                  label: "Password", // Set the label to "Password"
                  height: screenHeight * 0.06, // 6% of screen height
                ),
                SizedBox(height: screenHeight * 0.04), // Spacing after password field

                // ForgotPasswordButton aligned to the right
                Align(
                  alignment: Alignment.centerRight,
                  child: ForgotPasswordButton(
                    label: "Forgot Password?", // Set the label
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.01), // Reduced spacing between buttons

                // Don't have an account Button aligned to the right
                Align( // Wrap with Align
                  alignment: Alignment.centerRight, // Align to the right
                  child: ForgotPasswordButton(
                    label: "Don't have an account?", // Set the label
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // Spacing before Login button

                // RedButton for Login
                Center( // Keep Login button centered
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Color(0xFFA51414)) // Show loading indicator
                      : RedButton(
                          label: "Login", // Set the label to "Login"
                          width: screenWidth * 0.90, // 90% of screen width
                          height: screenHeight * 0.06, // 6% of screen height
                          onPressed: _login, // Call the login function
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