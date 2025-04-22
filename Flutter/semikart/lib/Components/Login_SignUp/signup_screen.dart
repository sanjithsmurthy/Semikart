import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:Semikart/managers/auth_manager.dart'; // Import AuthManager
// Removed BaseScaffold import as AuthWrapper handles navigation
// import '../../base_scaffold.dart';
import '../common/signinwith_google.dart';
import 'custom_text_field.dart';
import 'confirm_password.dart'; // Import the ConfirmPasswordScreen component
import 'password_text_field.dart'; // Import the PasswordTextField widget
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/inactive_red_button.dart'; // Import the InactiveButton widget
import 'login_password.dart'; // Import the LoginScreen component
import '../common/forgot_password.dart';
import 'package:intl_phone_field/intl_phone_field.dart'; // Import the IntlPhoneField package

// --- Changed to ConsumerStatefulWidget ---
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key}); // Added super.key

  @override
  // --- Changed to ConsumerState ---
  _SignUpScreenState createState() => _SignUpScreenState();
}

// --- Changed to ConsumerState ---
class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  bool passwordsMatch = false; // Track if passwords match
  bool isTermsAccepted = false; // Track if the checkbox is checked
  bool _areAllFieldsFilled = false; // Track if all required fields are filled
  bool _isLoading = false; // Loading indicator state

  // Controllers for text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  // Password controllers are managed within ConfirmPasswordScreen, but we need access to the password itself
  final TextEditingController _passwordController = TextEditingController(); // Add controller for password
  final TextEditingController _confirmPasswordController = TextEditingController(); // Add controller for confirm password

  @override
  void initState() {
    super.initState();
    // Add listeners to all controllers to check field status
    firstNameController.addListener(_checkAllFieldsFilled);
    lastNameController.addListener(_checkAllFieldsFilled);
    emailController.addListener(_checkAllFieldsFilled);
    mobileNumberController.addListener(_checkAllFieldsFilled);
    companyNameController.addListener(_checkAllFieldsFilled);
    _passwordController.addListener(_checkAllFieldsFilled); // Listen to password
    _confirmPasswordController.addListener(_checkAllFieldsFilled); // Listen to confirm password
  }

  @override
  void dispose() {
    // Remove listeners
    firstNameController.removeListener(_checkAllFieldsFilled);
    lastNameController.removeListener(_checkAllFieldsFilled);
    emailController.removeListener(_checkAllFieldsFilled);
    mobileNumberController.removeListener(_checkAllFieldsFilled);
    companyNameController.removeListener(_checkAllFieldsFilled);
    _passwordController.removeListener(_checkAllFieldsFilled);
    _confirmPasswordController.removeListener(_checkAllFieldsFilled);

    // Dispose controllers
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    companyNameController.dispose();
    _passwordController.dispose(); // Dispose password controller
    _confirmPasswordController.dispose(); // Dispose confirm password controller
    super.dispose();
  }

  // Function to check if all required fields are non-empty and passwords match
  void _checkAllFieldsFilled() {
    setState(() {
      passwordsMatch = _passwordController.text.isNotEmpty &&
                       _passwordController.text == _confirmPasswordController.text;

      _areAllFieldsFilled = firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          mobileNumberController.text.isNotEmpty &&
          companyNameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty; // Check password field too
    });
  }

  // --- Sign Up Logic ---
  Future<void> _signUp() async {
    FocusScope.of(context).unfocus(); // Hide keyboard

    if (!isSignUpButtonActive) return; // Should not happen if button is inactive, but good check

    setState(() { _isLoading = true; });

    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final mobile = mobileNumberController.text.trim(); // Assuming full number is stored
    final company = companyNameController.text.trim();
    final password = _passwordController.text.trim(); // Get password from its controller

    // Use AuthManager via Riverpod
    final authManager = ref.read(authManagerProvider.notifier);
    // Pass necessary details (adjust based on your actual signup needs)
    final success = await authManager.signUp(email, password, "$firstName $lastName"); // Combine names for simulation

    if (!mounted) return;

    setState(() { _isLoading = false; });

    // AuthWrapper handles navigation on success. Show error if failed.
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign up failed. Please try again.'),
          backgroundColor: Color(0xFFA51414),
          duration: Duration(seconds: 3),
        ),
      );
    }
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
                    onPressed: () {
                      print('Google Sign-In button pressed');
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Google Sign-Up not implemented yet.')),
                      );
                    },
                    isLoading: false,
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
                    // keyboardType: TextInputType.emailAddress, // Set keyboard type - Parameter not defined in CustomTextField
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // IntlPhoneField for Mobile Number
                Center(
                  child: LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    final double responsiveBorderRadius = screenWidth * 0.06;

                    return IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: const TextStyle(color: Color(0xFF757575)),
                      floatingLabelStyle: const TextStyle(color: Color(0xFFA51414)),
                      border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFA51414),width: 2.0),
                      borderRadius: BorderRadius.circular(responsiveBorderRadius),
                      ),
                      enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFA51414),width: 2.0),
                      borderRadius: BorderRadius.circular(responsiveBorderRadius),
                      ),
                      focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFA51414), width: 2.0),
                      borderRadius: BorderRadius.circular(responsiveBorderRadius),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                      counterText: '',
                    ),
                    initialCountryCode: 'IN',
                    keyboardType: TextInputType.phone, // Set keyboard type
                    onChanged: (phone) {
                      mobileNumberController.text = phone.completeNumber;
                       _checkAllFieldsFilled();
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                    dropdownIcon: const Icon(Icons.arrow_drop_down, color: Color(0xFFA51414)),
                    );
                  }
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

                // --- Use PasswordTextField directly ---
                PasswordTextField(
                  controller: _passwordController,
                  label: "Password",
                  height: screenHeight * 0.06, // Match height if needed
                  onChanged: (_) => _checkAllFieldsFilled(), // Check fields on change
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing
                PasswordTextField(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                  height: screenHeight * 0.06, // Match height if needed
                  onChanged: (_) => _checkAllFieldsFilled(), // Check fields on change
                ),
                // Display error if passwords don't match and confirm field is touched
                 if (_confirmPasswordController.text.isNotEmpty && !passwordsMatch)
                   Padding(
                     padding: const EdgeInsets.only(top: 8.0, left: 12.0), // Adjust padding
                     child: Text(
                       'Passwords do not match',
                       style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                     ),
                   ),
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
                  alignment: Alignment.centerRight, // Align the entire row to the right
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
                            textAlign: TextAlign.right, // Align text to the right
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