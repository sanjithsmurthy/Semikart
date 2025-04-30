import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Semikart/managers/auth_manager.dart'; // Use the new AuthManager
import 'package:Semikart/app_navigator.dart'; // Import AppNavigator
import '../common/signinwith_google.dart';
import 'custom_text_field.dart';
import 'password_text_field.dart'; // Import PasswordTextField
import '../common/red_button.dart';
import '../common/inactive_red_button.dart';
import 'login_password.dart';
import '../common/forgot_password.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  // Keep local state for form validation and UI
  bool passwordsMatch = false;
  bool isTermsAccepted = false;
  bool _areAllFieldsFilled = false;
  bool _isLoading = false; // Local loading state for button feedback

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController(); // Keep if needed for profile
  final companyNameController = TextEditingController(); // Keep if needed for profile
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add listeners to check field status and password match
    firstNameController.addListener(_checkAllFieldsFilled);
    lastNameController.addListener(_checkAllFieldsFilled);
    emailController.addListener(_checkAllFieldsFilled);
    mobileNumberController.addListener(_checkAllFieldsFilled); // Keep listener if field is kept
    companyNameController.addListener(_checkAllFieldsFilled); // Keep listener if field is kept
    _passwordController.addListener(_checkPasswordsAndFields);
    _confirmPasswordController.addListener(_checkPasswordsAndFields);
  }

   @override
  void dispose() {
    // Remove listeners
    firstNameController.removeListener(_checkAllFieldsFilled);
    lastNameController.removeListener(_checkAllFieldsFilled);
    emailController.removeListener(_checkAllFieldsFilled);
    mobileNumberController.removeListener(_checkAllFieldsFilled);
    companyNameController.removeListener(_checkAllFieldsFilled);
    _passwordController.removeListener(_checkPasswordsAndFields);
    _confirmPasswordController.removeListener(_checkPasswordsAndFields);

    // Dispose controllers
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    companyNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordsAndFields() {
     setState(() {
        passwordsMatch = _passwordController.text.isNotEmpty &&
                         _passwordController.text == _confirmPasswordController.text;
        _checkAllFieldsFilled(); // Also re-check all fields
     });
  }

  void _checkAllFieldsFilled() {
    // Check essential fields for Firebase email/password signup
    setState(() {
      _areAllFieldsFilled = firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
          // Removed mobileNumberController and companyNameController checks
          // as they are not strictly required for Firebase auth,
          // but can be added back if needed for profile creation later.
    });
  }

  Future<void> _signUp() async {
    FocusScope.of(context).unfocus();
    if (!isSignUpButtonActive || _isLoading) return;

    setState(() { _isLoading = true; });

    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = _passwordController.text.trim();
    final displayName = "$firstName $lastName".trim();

    final authManager = ref.read(authManagerProvider.notifier);
    await authManager.signUp(email, password, displayName);

    if (!mounted) return;
    setState(() { _isLoading = false; });
  }

   Future<void> _googleSignIn() async {
     FocusScope.of(context).unfocus();
     if (_isLoading) return; // Prevent multiple clicks if already loading

     setState(() { _isLoading = true; });

     final authManager = ref.read(authManagerProvider.notifier);
     await authManager.googleSignIn();

     if (!mounted) return;
     setState(() { _isLoading = false; });
  }

  // Determine if the sign-up button should be active
  bool get isSignUpButtonActive => _areAllFieldsFilled && passwordsMatch && isTermsAccepted && !_isLoading;


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
                SizedBox(height: screenHeight * 0.08), // Space for the logo

                // Semikart Logo
                Image.asset(
                  'public/assets/images/semikart_logo_medium.png',
                  width: screenWidth * 0.4, // 40% of screen width
                  height: screenHeight * 0.05, // 5% of screen height
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // "Create Your Account" Text
                Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.055, // 6% of screen width
                    color: Colors.black, // Black text color
                    fontWeight: FontWeight.bold, // Bold font weight
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // Google Sign-In Button
                Center(
                  child: SignInWithGoogleButton(
                    onPressed: _googleSignIn,
                    isLoading: _isLoading,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // Divider with "OR"
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                        endIndent: screenWidth * 0.02, // Specify spacing
                      ),
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Specify font size
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                        indent: screenWidth * 0.02, // Specify spacing
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03), // Add spacing

                // CustomTextField for First Name
                Center(
                  child: CustomTextField(
                    controller: firstNameController,
                    label: "First Name",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // CustomTextField for Last Name
                Center(
                  child: CustomTextField(
                    controller: lastNameController,
                    label: "Last Name",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // CustomTextField for Email
                Center(
                  child: CustomTextField(
                    controller: emailController,
                    label: "Email",
                    // keyboardType: TextInputType.emailAddress, // Parameter not defined
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // IntlPhoneField for Mobile Number
                Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final screenWidth = MediaQuery.of(context).size.width;
                      final double responsiveBorderRadius = screenWidth * 0.028;

                      return TextSelectionTheme(
                        data: const TextSelectionThemeData(
                          selectionColor: Color(0xFFA51414), // Highlight color for selected text
                          selectionHandleColor: Color(0xFFA51414), // Color for the drop icon
                        ),
                        child: IntlPhoneField(
                          cursorColor: const Color(0xFFA51414),
                          cursorWidth: 1,
                          // --- Apply input formatters ---
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly, // Allow only digits
                            LengthLimitingTextInputFormatter(10), // Limit length to 10 digits
                          ],
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            labelStyle: const TextStyle(color: Color(0xFF757575)),
                            floatingLabelStyle: const TextStyle(color: Color(0xFFA51414)),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFFA51414), width: 1.0),
                              borderRadius: BorderRadius.circular(responsiveBorderRadius),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFFA51414), width: 1.0),
                              borderRadius: BorderRadius.circular(responsiveBorderRadius),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFFA51414), width: 1.0),
                              borderRadius: BorderRadius.circular(responsiveBorderRadius),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                            counterText: '', // Hide the default counter
                          ),
                          initialCountryCode: 'IN',
                          keyboardType: TextInputType.phone, // Keep for keyboard type suggestion
                          onChanged: (phone) {
                            // phone.completeNumber includes the selected country code + the digits entered.
                            // phone.number includes ONLY the digits entered.
                            // The inputFormatter ensures phone.number contains only digits.
                            mobileNumberController.text = phone.completeNumber; // Store the full number with country code
                            _checkAllFieldsFilled();
                            print('Complete Number stored: ${phone.completeNumber}');
                          },
                          onCountryChanged: (country) {
                            print('Country changed to: ' + country.name);
                            // --- Apply the changes ---
                            // Clear the input field when country changes
                            mobileNumberController.clear();
                            // Re-check if all fields are filled as mobile number is now empty
                            _checkAllFieldsFilled();
                          },
                          dropdownIcon: const Icon(Icons.arrow_drop_down, color: Color(0xFFA51414)),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.025), // Add spacing

                // CustomTextField for Company Name
                Center(
                  child: CustomTextField(
                    controller: companyNameController,
                    label: "Company Name",
                  ),
                ),
                SizedBox(height: screenHeight * 0.015), // Add spacing

                // --- Integrated Password Fields ---
                // Password Input Field
                PasswordTextField(
                  controller: _passwordController,
                  label: "Password",
                  // Optional: Add validation or onChanged if needed directly here
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // Confirm Password Input Field
                PasswordTextField(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                  // Optional: Add validation or onChanged if needed directly here
                ),
                // --- End Integrated Password Fields ---

                SizedBox(height: screenHeight * 0.02), // Add spacing


                // ForgotPasswordButton for "Already have an account?"
                Align(
                  alignment: Alignment.centerRight, // Align to the right
                  child: ForgotPasswordButton(
                    label: "Already have an account?", // Specify label
                    onPressed: () {
                      // Navigate back or to login screen
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        // If cannot pop (e.g., deep linked), navigate explicitly
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPasswordNewScreen()),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // Checkbox for Terms and Conditions
                Align(
                  alignment: Alignment.center, // Align the entire row to the right
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Minimize the row's width
                    children: [
                      Checkbox(
                        value: isTermsAccepted,
                        onChanged: (value) {
                          setState(() {
                            isTermsAccepted = value ?? false; // Update the checkbox state
                          });
                          _checkAllFieldsFilled(); // Re-check button state
                        },
                        activeColor: const Color(0xFFA51414), // Set checkbox color
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area
                        visualDensity: VisualDensity.compact, // Make checkbox smaller
                      ),
                      Flexible(
                        child: GestureDetector( // Allow tapping text to toggle checkbox
                          onTap: () {
                             setState(() {
                               isTermsAccepted = !isTermsAccepted;
                             });
                             _checkAllFieldsFilled();
                          },
                          child: Text(
                            "I agree to the terms and conditions",
                            style: TextStyle(
                              fontSize: screenWidth * 0.035, // Specify font size
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center, // Align text to the right
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // Sign Up Button
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Color(0xFFA51414))
                      : isSignUpButtonActive
                          ? RedButton(
                              label: "Sign Up",
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.06,
                              onPressed: _signUp, // Call the signup function
                              // --- REMOVED Navigator.pushReplacement ---
                            )
                          : InactiveButton(
                              label: "Sign Up",
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.06,
                            ),
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 30), // Keyboard height + buffer
              ],
            ),
          ),
        ),
      ),
    );
  }
}