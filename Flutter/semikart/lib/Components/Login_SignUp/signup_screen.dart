import 'package:flutter/material.dart';
import '../../base_scaffold.dart'; // Import BaseScaffold for navigation
import '../common/signinwith_google.dart';
import 'custom_text_field.dart';
import 'confirm_password.dart'; // Import the ConfirmPasswordScreen component // Import the MobileNumberField component
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/inactive_red_button.dart'; // Import the InactiveButton widget
import 'login_password.dart'; // Import the LoginScreen component (assuming login_password_new.dart)
import '../common/forgot_password.dart';
import 'package:intl_phone_field/intl_phone_field.dart'; // Import the IntlPhoneField package

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passwordsMatch = false; // Track if passwords match
  bool isTermsAccepted = false; // Track if the checkbox is checked
  bool _areAllFieldsFilled = false; // Track if all required fields are filled

  // Controllers for text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  // Note: Password controllers are inside ConfirmPasswordScreen

  @override
  void initState() {
    super.initState();
    // Add listeners to all controllers to check field status
    firstNameController.addListener(_checkAllFieldsFilled);
    lastNameController.addListener(_checkAllFieldsFilled);
    emailController.addListener(_checkAllFieldsFilled);
    mobileNumberController.addListener(_checkAllFieldsFilled);
    companyNameController.addListener(_checkAllFieldsFilled);
  }

  @override
  void dispose() {
    // Remove listeners
    firstNameController.removeListener(_checkAllFieldsFilled);
    lastNameController.removeListener(_checkAllFieldsFilled);
    emailController.removeListener(_checkAllFieldsFilled);
    mobileNumberController.removeListener(_checkAllFieldsFilled);
    companyNameController.removeListener(_checkAllFieldsFilled);

    // Dispose controllers
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    companyNameController.dispose();
    super.dispose();
  }

  // Function to check if all required fields are non-empty
  void _checkAllFieldsFilled() {
    setState(() {
      _areAllFieldsFilled = firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          mobileNumberController.text.isNotEmpty &&
          companyNameController.text.isNotEmpty;
          // Note: Password field check is handled by the passwordsMatch flag
          // which comes from ConfirmPasswordScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Determine if the sign-up button should be active
    final bool isSignUpButtonActive = _areAllFieldsFilled && passwordsMatch && isTermsAccepted;

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
                     // Use Product Sans font
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
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                Center(
                  child: LayoutBuilder( // Use LayoutBuilder to get constraints if needed, or just use MediaQuery
                  builder: (context, constraints) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    // Calculate a responsive border radius. 25% of width/height might be too much,
                    // let's use a fraction of screen width for a scalable effect.
                    // Adjust the multiplier (e.g., 0.06) as needed for the desired curve.
                    final double responsiveBorderRadius = screenWidth * 0.06; // Example: 6% of screen width

                    return IntlPhoneField(
                    // controller: mobileNumberController, // Keep commented if not needed
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: TextStyle(color: Color(0xFFA51414)), // Style from CustomTextField
                      floatingLabelStyle: TextStyle(color: Color(0xFFA51414)), // Style from CustomTextField
                      border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFA51414),width: 2.0),
                      borderRadius: BorderRadius.circular(responsiveBorderRadius), // Use responsive radius
                      ),
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFA51414),width: 2.0),
                      borderRadius: BorderRadius.circular(responsiveBorderRadius), // Use responsive radius
                      ),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFA51414), width: 2.0), // Style from CustomTextField
                      borderRadius: BorderRadius.circular(responsiveBorderRadius), // Use responsive radius
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0), // Style from CustomTextField
                    ),
                    initialCountryCode: 'IN', // Default country code
                    onChanged: (phone) {
                      // Update state or controller if needed
                      mobileNumberController.text = phone.completeNumber; // Assuming you want to store the full number
                       _checkAllFieldsFilled(); // Call check function on change
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                    // Style the dropdown icon color
                    dropdownIcon: Icon(Icons.arrow_drop_down, color: Color(0xFFA51414)),
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

                // Confirm Password Component
                ConfirmPasswordScreen(
                  onPasswordsMatch: (match) {
                    if (passwordsMatch != match) {
                      setState(() {
                        passwordsMatch = match; // Update the passwordsMatch state
                      });
                      _checkAllFieldsFilled();
                    }
                  },
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // ForgotPasswordButton
                Align(
                  alignment: Alignment.centerRight, // Align to the right
                  child: ForgotPasswordButton(
                    label: "Already have an account?", // Specify label
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPasswordNewScreen()), // Navigate to LoginScreen
                      );
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
                          _checkAllFieldsFilled();
                        },
                        activeColor: Color(0xFFA51414), // Set checkbox color
                      ),
                      Flexible(
                        child: Text(
                          "I agree to the terms and conditions",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035, // Specify font size
                            
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right, // Align text to the right
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Add spacing

                // Sign Up Button
                Center(
                  child: isSignUpButtonActive
                      ? RedButton(
                          label: "Sign Up", // Specify label
                          width: screenWidth * 0.9, // Specify width
                          height: screenHeight * 0.06, // Specify height
                          onPressed: () {
                            print("Sign Up Initiated!");
                            print("First Name: ${firstNameController.text}");
                            print("Last Name: ${lastNameController.text}");
                            print("Email: ${emailController.text}");
                            print("Mobile: ${mobileNumberController.text}");
                            print("Company: ${companyNameController.text}");
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => BaseScaffold()), // Navigate to HomePage
                            );
                          },
                        )
                      : InactiveButton(
                          label: "Sign Up", // Specify label
                          width: screenWidth * 0.9, // Specify width
                          height: screenHeight * 0.06, // Specify height
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