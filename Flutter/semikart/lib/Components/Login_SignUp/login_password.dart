import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart'; // Import the logging package
import '../common/signinwith_google.dart';
import 'vertical_radios.dart';
import 'custom_text_field.dart';
import 'password_text_field.dart';
import '../common/forgot_password.dart';
import '../common/red_button.dart';
import 'signup_screen.dart';
import 'forgot_password.dart';

// Convert to StatefulWidget
class LoginPasswordScreen extends StatefulWidget {
  const LoginPasswordScreen({super.key}); // Add key

  @override
  State<LoginPasswordScreen> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  // Create a logger instance for this screen
  final _log = Logger('LoginPasswordScreen');

  // Define controllers here
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Dispose controllers
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaPadding = MediaQuery.of(context).padding;
    final availableHeight = screenHeight - safeAreaPadding.top - safeAreaPadding.bottom;

    // Define the height/position where scrolling should start
    final double scrollStartThreshold = availableHeight * 0.40; // Adjust this value as needed

    return Scaffold(
      // No need for resizeToAvoidBottomInset here as we handle scrolling manually
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox( // Constrain the Stack to SafeArea bounds
          height: availableHeight,
          width: screenWidth,
          child: Stack(
            children: [
              // --- Fixed Elements ---
              // White background (covers entire Stack)
              Container(
                color: Colors.white,
              ),

              // Positioned Semikart logo
              Positioned(
                left: screenWidth * 0.05,
                top: availableHeight * 0.08, // Use availableHeight for positioning
                child: Image.asset(
                  'public/assets/images/semikart_logo_medium.png',
                  width: screenWidth * 0.4,
                  height: availableHeight * 0.05,
                  fit: BoxFit.contain,
                ),
              ),

              // Positioned Login text
              Positioned(
                left: screenWidth * 0.05,
                top: availableHeight * 0.18, // Use availableHeight
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontFamily: 'Product Sans',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Positioned SignInWithGoogleButton
              Positioned(
                left: screenWidth * 0.05,
                top: availableHeight * 0.25, // Use availableHeight
                child: SignInWithGoogleButton(
                  onPressed: () {
                    print('Google Sign-In button pressed');
                  },
                  isLoading: false,
                  isTwoLine: true,
                ),
              ),

              // Positioned VerticalRadios
              Positioned(
                left: screenWidth * 0.55,
                top: availableHeight * 0.22, // Use availableHeight
                child: VerticalRadios(
                  initialOption: "password",
                  // Add onChanged if needed to handle state
                ),
              ),

              // --- Scrollable Area ---
              Positioned(
                top: scrollStartThreshold, // Start scrolling content from here
                left: 0, // Take full width for positioning context
                right: 0,
                bottom: 0, // Extend to the bottom of the Stack
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.05,
                    right: screenWidth * 0.05,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20, // Add padding for keyboard and some space
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch, // Make children take full width
                    children: [
                      // Email Field (No longer Positioned)
                      CustomTextField(
                        controller: _emailController,
                        // width: screenWidth * 0.9, // Width is handled by Column's stretch
                        label: "Email",
                        height: availableHeight * 0.06, // Use availableHeight
                      ),
                      SizedBox(height: availableHeight * 0.02), // Spacing based on height

                      // Password Field (No longer Positioned)
                      PasswordTextField(
                        controller: _passwordController,
                        // width: screenWidth * 0.9, // Width is handled by Column's stretch
                        label: "Password",
                        height: availableHeight * 0.06, // Use availableHeight
                      ),
                      SizedBox(height: availableHeight * 0.02), // Spacing

                      // Forgot Password Button (Aligned Right)
                      Align(
                        alignment: Alignment.centerRight,
                        child: ForgotPasswordButton(
                          label: "Forgot Password?",
                          onPressed: () {
                            _log.info("Navigating to Forgot Password Screen"); // Log navigation
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: availableHeight * 0.01), // Spacing

                      // Don't have an account Button (Aligned Right)
                      Align(
                        alignment: Alignment.centerRight,
                        child: ForgotPasswordButton(
                          label: "Don't have an account?",
                          onPressed: () {
                             _log.info("Navigating to Sign Up Screen"); // Log navigation
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpScreen()),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: availableHeight * 0.04), // Spacing before Login button

                      // Login Button (No longer Positioned)
                      RedButton(
                        label: "Login",
                        // width: screenWidth * 0.90, // Width handled by Column
                        height: availableHeight * 0.06, // Use availableHeight
                        onPressed: () {
                          // Use the logger instead of print
                          _log.info('Login button clicked');
                          _log.fine('Attempting login with Email: ${_emailController.text}'); // Use fine for potentially sensitive data in debug
                          // Avoid logging passwords directly, even at fine level, in production builds.
                          // _log.fine('Password: ${_passwordController.text}'); // Be cautious with logging passwords

                          // TODO: Add form validation and actual login logic here
                          // if (_formKey.currentState!.validate()) { ... }
                        },
                      ),
                      // Add some extra space at the bottom if needed, especially if keyboardPadding isn't enough
                      // SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}