import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Semikart/managers/auth_manager.dart'; // Use the new AuthManager
import '../common/signinwith_google.dart';
import 'custom_text_field.dart';
import 'password_text_field.dart'; // Keep PasswordTextField import
import '../common/red_button.dart';
import '../common/inactive_red_button.dart';
import 'login_password.dart';
import '../common/forgot_password.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';
// Removed ConfirmPasswordScreen import

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  // --- Integrated State from ConfirmPasswordScreen ---
  // bool passwordsMatch = false; // Removed, replaced by _isPasswordMatching()
  bool isTermsAccepted = false;
  bool _areAllFieldsFilled = false;
  bool _isLoading = false; // Local loading state for button feedback

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final companyNameController = TextEditingController();
  final _passwordController = TextEditingController(); // Keep
  final _confirmPasswordController = TextEditingController(); // Keep

  // Password validation flags (from ConfirmPasswordScreen)
  bool hasMinLength = false;
  bool hasUpperCase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  // --- End Integrated State ---


  @override
  void initState() {
    super.initState();
    // Add listeners to check field status and password validation
    firstNameController.addListener(_checkAllFieldsFilled);
    lastNameController.addListener(_checkAllFieldsFilled);
    emailController.addListener(_checkAllFieldsFilled);
    mobileNumberController.addListener(_checkAllFieldsFilled);
    companyNameController.addListener(_checkAllFieldsFilled);
    _passwordController.addListener(() { // Add password validation listener here
      _validatePassword(_passwordController.text);
      _checkAllFieldsFilled();
    });
    _confirmPasswordController.addListener(() { // Update UI on confirm password change
      setState(() {});
      _checkAllFieldsFilled(); // Also re-check overall fields
    });
  }

   @override
  void dispose() {
    // Remove listeners
    firstNameController.removeListener(_checkAllFieldsFilled);
    lastNameController.removeListener(_checkAllFieldsFilled);
    emailController.removeListener(_checkAllFieldsFilled);
    mobileNumberController.removeListener(_checkAllFieldsFilled);
    companyNameController.removeListener(_checkAllFieldsFilled);
    _passwordController.removeListener(() { _validatePassword(_passwordController.text); _checkAllFieldsFilled(); }); // Match listener removal
    _confirmPasswordController.removeListener(() { setState(() {}); _checkAllFieldsFilled(); }); // Match listener removal

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

  // Removed _checkPasswordsAndFields - logic integrated into listeners/getters

  void _checkAllFieldsFilled() {
    // Check essential fields for Firebase email/password signup
    // Also check password requirements and match for button state
    setState(() {
      _areAllFieldsFilled = firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty && // Ensure password is not empty
          _confirmPasswordController.text.isNotEmpty; // Ensure confirm password is not empty
    });
  }

  // --- Integrated Methods from ConfirmPasswordScreen ---
  void _validatePassword(String password) {
    setState(() {
      hasMinLength = password.length >= 8 && password.length <= 20;
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      _checkAllFieldsFilled(); // Re-check overall fields when password changes
    });
  }

  bool _isPasswordMatching() {
    return _passwordController.text == _confirmPasswordController.text;
  }

  bool _areAllRequirementsSatisfied() {
    return hasMinLength && hasUpperCase && hasNumber && hasSpecialChar;
  }

  Widget _buildRequirementItem(String text, bool isSatisfied, double fontSize, double iconSize, double spacing, double leftPadding) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: iconSize,
            color: isSatisfied ? Color.fromARGB(255, 25, 107, 27) : Color(0xFF989DA3),
          ),
          SizedBox(width: spacing * 2.5),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: Color(0xFF989DA3),
            ),
          ),
        ],
      ),
    );
  }
  // --- End Integrated Methods ---


  Future<void> _signUp() async {
    FocusScope.of(context).unfocus();
    if (!isSignUpButtonActive || _isLoading) return;

    setState(() { _isLoading = true; });

    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = _passwordController.text.trim();
    final companyName = companyNameController.text.trim();
    final phoneNumber = mobileNumberController.text.trim(); // Assuming this holds the complete number

    final authManager = ref.read(authManagerProvider.notifier);
    // Call the updated signUp method with all the details
    await authManager.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      companyName: companyName,
      phoneNumber: phoneNumber,
    );

    if (!mounted) return;
    setState(() { _isLoading = false; });
  }

   Future<void> _googleSignIn() async {
     FocusScope.of(context).unfocus();
     if (_isLoading) return;

     setState(() { _isLoading = true; });
     final authManager = ref.read(authManagerProvider.notifier);
    //  await authManager.googleSignIn();

     if (!mounted) return;
     setState(() { _isLoading = false; });
  }

  // Determine if the sign-up button should be active using integrated logic
  bool get isSignUpButtonActive =>
      _areAllFieldsFilled &&
      _areAllRequirementsSatisfied() && // Check requirements
      _isPasswordMatching() && // Check match
      isTermsAccepted &&
      !_isLoading;


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // --- Dynamic sizes from ConfirmPasswordScreen ---
    final double verticalSpacingSmall = screenHeight * 0.01;
    final double verticalSpacingMedium = screenHeight * 0.02;
    final double verticalSpacingLarge = screenHeight * 0.03;
    final double textFieldHeight = screenHeight * 0.06;
    final double headingFontSize = screenWidth * 0.04 * 0.75;
    final double requirementFontSize = screenWidth * 0.035 * 0.75;
    final double bulletIconSize = screenWidth * 0.03;
    final double checkIconSize = screenWidth * 0.05;
    final double alertIconSize = screenWidth * 0.04;
    final double alertFontSize = screenWidth * 0.03;
    final double leftPaddingValue = screenWidth * 0.075;
    // --- End Dynamic sizes ---

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ... (Logo, Title, Google Sign In, OR Divider - unchanged) ...
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


                // --- Integrated Password Section ---
                // Password Field
                PasswordTextField(
                  controller: _passwordController,
                  label: "Password",
                  height: textFieldHeight,
                  onChanged: _validatePassword, // Use the integrated validator
                ),

                SizedBox(height: verticalSpacingLarge),

                // Password Requirements Heading and List
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: leftPaddingValue),
                      child: Text(
                        "YOUR PASSWORD MUST CONTAIN",
                        style: TextStyle(
                          fontSize: headingFontSize,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF989DA3),
                        ),
                      ),
                    ),
                    SizedBox(height: verticalSpacingSmall),
                    _buildRequirementItem("Between 8 and 20 characters", hasMinLength, requirementFontSize, bulletIconSize, verticalSpacingSmall, leftPaddingValue),
                    SizedBox(height: verticalSpacingSmall),
                    _buildRequirementItem("1 upper case letter", hasUpperCase, requirementFontSize, bulletIconSize, verticalSpacingSmall, leftPaddingValue),
                    SizedBox(height: verticalSpacingSmall),
                    _buildRequirementItem("1 or more numbers", hasNumber, requirementFontSize, bulletIconSize, verticalSpacingSmall, leftPaddingValue),
                    SizedBox(height: verticalSpacingSmall),
                    _buildRequirementItem("1 or more special characters", hasSpecialChar, requirementFontSize, bulletIconSize, verticalSpacingSmall, leftPaddingValue),
                  ],
                ),

                SizedBox(height: verticalSpacingLarge),

                // Confirm Password Field (Using PasswordTextField)
                PasswordTextField( // Use PasswordTextField for consistency
                  controller: _confirmPasswordController,
                  height: textFieldHeight, // Assuming PasswordTextField accepts height
                  label: "Confirm Password",
                  // obscureText is handled internally by PasswordTextField
                  // suffixIcon is likely handled internally (visibility toggle), removing custom icon
                  // Keep onChanged to trigger UI updates and checks
                  onChanged: (value) {
                    // Update UI state, e.g., for the mismatch alert below and button state
                    setState(() {});
                    _checkAllFieldsFilled(); // Re-check button state
                  },
                ),

                // Alert Text for Password Mismatch (Keep this logic, it depends on the controllers)
                if (!_isPasswordMatching() && _confirmPasswordController.text.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: verticalSpacingSmall, left: leftPaddingValue),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: Color(0xFFA51414),
                          size: alertIconSize,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          "Passwords do not match",
                          style: TextStyle(
                            fontSize: alertFontSize,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFA51414),
                          ),
                        ),
                      ],
                    ),
                  ),
                // --- End Integrated Password Section ---

                SizedBox(height: screenHeight * 0.02), // Add spacing


                // ForgotPasswordButton for "Already have an account?"
                Align(
                  alignment: Alignment.centerRight,
                  child: ForgotPasswordButton(
                    label: "Already have an account?",
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
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
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: isTermsAccepted,
                        onChanged: (value) {
                          setState(() {
                            isTermsAccepted = value ?? false;
                          });
                          // No need to call _checkAllFieldsFilled here, getter handles it
                        },
                        activeColor: const Color(0xFFA51414),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            setState(() { // Toggle checkbox when text is tapped
                              isTermsAccepted = !isTermsAccepted;
                            });
                          },
                          child: RichText( // Use RichText for clickable "Terms & Conditions"
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: screenWidth * 0.035, // Adjust font size as needed
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(text: "I agree to the "),
                                TextSpan(
                                  text: "Terms & Conditions",
                                  style: TextStyle(
                                    color: Color(0xFFA51414), // Make terms link color red
                                    decoration: TextDecoration.underline, // Underline to indicate link
                                  ),
                                  // TODO: Add recognizer to handle tap on "Terms & Conditions"
                                  // recognizer: TapGestureRecognizer()..onTap = () {
                                  //   print("Navigate to Terms & Conditions");
                                  //   // Add navigation logic here
                                  // },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // Sign Up Button (uses updated isSignUpButtonActive getter)
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Color(0xFFA51414))
                      : isSignUpButtonActive
                          ? RedButton(
                              label: "Sign Up",
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.06,
                              onPressed: _signUp,
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