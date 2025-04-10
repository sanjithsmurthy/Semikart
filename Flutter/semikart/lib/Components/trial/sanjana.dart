import 'package:flutter/material.dart';
import '../Login_SignUp/custom_text_field.dart';
import '../common/textfield_dropdown.dart';
import '../common/red_button.dart';
import '../common/inactive_red_button.dart';
import '../common/white_button.dart';
import '../common/track_order.dart';
import '../common/captcha.dart';
import '../common/signinwith_google.dart';
import '../common/two_radios.dart';
import '../common/RFQ_CTA.dart';
import '../common/cartempty.dart';
import '../common/order_view.dart';
import '../common/profilepic.dart';
import '../common/product_search.dart'; // Import the ProductSearch page
import '../common/search_builtin.dart' as custom; // Import the built-in SearchBar with alias
import '../common/mobile_number_input.dart'; // Import the MobileNumberField component
import '../Login_SignUp/password_text_field.dart'; // Import the PasswordTextField widget
import '../Login_SignUp/Loginpassword.dart'; // Import the LoginPasswordScreen
import '../Login_SignUp/LoginOTP.dart'; // Adjust the path as needed
import '../Login_SignUp/vertical_radios.dart'; // Import the VerticalRadios widget
import '../Login_SignUp/confirm_password.dart'; // Import the ConfirmPasswordScreen
import 'dart:io';
import '../Login_SignUp/success.dart';

class TestLayoutSanjana extends StatefulWidget {
  const TestLayoutSanjana({super.key});

  @override
  State<TestLayoutSanjana> createState() => _TestLayoutSanjanaState();
}

class _TestLayoutSanjanaState extends State<TestLayoutSanjana> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController(); // Controller for the password field
  final TextEditingController _otpController = TextEditingController(); // Controller for the OTP field
  String? _selectedState;
  bool _isCaptchaValid = false; // Add this state variable
  int _selectedRadio = 0; // Add this state variable
  bool _showSearchOverlay = false; // State to control the overlay visibility

  void _toggleSearchOverlay() {
    setState(() {
      _showSearchOverlay = !_showSearchOverlay;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose(); // Dispose the password controller
    _otpController.dispose(); // Dispose the OTP controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<OrderStep> orderSteps = [
      OrderStep(
        title: 'Order Placed',
        location: 'Your order has been placed successfully',
        icon: Icons.shopping_cart_outlined,
        timestamp: '24 Mar, 2024 10:30 AM',
      ),
      OrderStep(
        title: 'Order Accepted',
        location: 'Seller has accepted your order',
        icon: Icons.check_circle_outline,
        timestamp: '24 Mar, 2024 11:45 AM',
      ),
      OrderStep(
        title: 'Contacted Supplier',
        location: 'Processing with supplier',
        icon: Icons.contact_phone_outlined,
        timestamp: '24 Mar, 2024 2:30 PM',
      ),
      OrderStep(
        title: 'In Transit',
        location: 'Package in international transit',
        icon: Icons.flight_takeoff_outlined,
        timestamp: null,
      ),
      OrderStep(
        title: 'Custom Clearance',
        location: 'Package clearing customs',
        icon: Icons.gavel_outlined,
        timestamp: null,
      ),
      OrderStep(
        title: 'In Fulfillment Center',
        location: 'Package at local fulfillment center',
        icon: Icons.warehouse_outlined,
        timestamp: null,
      ),
      OrderStep(
        title: 'Shipped',
        location: 'Out for final delivery',
        icon: Icons.local_shipping_outlined,
        timestamp: null,
      ),
      OrderStep(
        title: 'Order Delivered',
        location: 'Package delivered successfully',
        icon: Icons.done_all_outlined,
        timestamp: null,
      ),
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Component Testing',
          style: TextStyle(fontFamily: 'Product Sans'),
        ),
        backgroundColor: Color(0xFFA51414),
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final contentPadding = maxWidth > 600 ? 40.0 : 20.0;
              final buttonWidth = maxWidth > 343 ? 343.0 : maxWidth - 40;

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: contentPadding,
                    vertical: 24.0, // Added vertical padding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Custom TextField',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: _emailController,
                        label: "Email",
                        width: 160.0, // Set the width to 160
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: TextEditingController(),
                        label: "Email",
                        // No width parameter provided, so it will use the default width (370.0)
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: TextEditingController(), // Provide a controller
                        label: "OTP", // Set the label to "OTP"
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Custom Dropdown',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      CustomDropdownField(
                        label: "Select State",
                        value: _selectedState,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedState = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Button Types',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: buttonWidth,
                              child: RedButton(
                                label: "Active Button",
                                onPressed: () {
                                  print('Red button pressed!');
                                },
                                // variant: 'big',
                                width: buttonWidth,
                              ),
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              width: buttonWidth,
                              child: InactiveButton(
                                label: "Inactive Button",
                              ),
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              width: buttonWidth,
                              child: WhiteButton(
                                label: "White Button",
                                onPressed: () {
                                  print('White button pressed!');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: SignInWithGoogleButton(
                          onPressed: () {
                            print('Google Sign In Pressed!');
                          },
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Captcha Validation',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      CustomCaptcha(
                        onValidated: (isValid) {
                          setState(() {
                            _isCaptchaValid = isValid;
                          });
                        },
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Radio Options',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      SizedBox(height: 32),
                      Text(
                        'Default Two Radio Buttons',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Default Two Radio Buttons
                      TwoRadioButtons(
                        options: ['Option 1', 'Option 2'], // Default two options
                        initialSelection: 0, // Default selection (0 for the first button)
                        onSelectionChanged: (int selectedValue) {
                          print('Selected value (default): $selectedValue');
                        },
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Three Radio Buttons',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Three Radio Buttons
                      TwoRadioButtons(
                        options: ['Option A', 'Option B', 'Option C'], // Three options
                        initialSelection: 1, // Default selection
                        onSelectionChanged: (int selectedValue) {
                          print('Selected value (three options): $selectedValue');
                        },
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Vertical Radios Example',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                     
                      SizedBox(height: 32), // Add spacing after the VerticalRadios
                      Text(
                        'Order Tracking',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TrackOrder(
                        steps: orderSteps,
                        currentStep: 2, // Shows progress up to Contacted Supplier
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Request For Quote',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: RFQComponent(),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: CartEmpty(),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Profile Picture',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ProfilePicture(
                          imageUrl: null, // Add image URL when available
                          onImageSelected: (File image) {
                            print('Image selected: ${image.path}');
                            // Handle image upload here
                          },
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Order Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: screenWidth * 0.9),
                        child: OrderView(),
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Mobile Number Field',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      MobileNumberField(
                        controller: TextEditingController(),
                        label: 'Mobile Number',
                        countryCodes: ['+91', '+1', '+44'], // List of country codes
                        defaultCountryCode: '+91', // Default country code
                        onCountryCodeChanged: (code) {
                          print('Selected country code: $code');
                        },
                        onValidationFailed: (number) {
                          print('Invalid mobile number: $number');
                        },
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Password Field',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      PasswordTextField(
                        controller: _passwordController,
                        label: "Password",
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      
                      SizedBox(height: 32), // Add spacing after the OTP field
                      Text(
                        'Product Search Page',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline, // Add underline for clickable text
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the ProductSearch page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductSearch(),
                            ),
                          );
                        },
                        child: Text(
                          'Go to Product Search Page',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Product Sans',
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the LoginPasswordScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'LoginPassword Page',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Product Sans',
                            color: Colors.blue, // Blue color to indicate it's clickable
                            decoration: TextDecoration.underline, // Underline for clickable text
                          ),
                        ),
                      ),
                      SizedBox(height: 32), // Add spacing after the text
                      GestureDetector(
                        onTap: () {
                          // Navigate to the LoginOTPScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginOTPScreen(), // Navigate to LoginOTPScreen
                            ),
                          );
                        },
                        child: Text(
                          'LoginOTP Page',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Product Sans',
                            color: Colors.blue, // Blue color to indicate it's clickable
                            decoration: TextDecoration.underline, // Underline for clickable text
                          ),
                        ),
                      ),
                      SizedBox(height: 32), // Add spacing after the text
                      SizedBox(height: 32), // Add spacing before the link
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SuccessScreen()),
                          );
                        },
                        child: Text(
                          'Go to Success Screen',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Product Sans',
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 32), // Add spacing after the link
                      Text(
                        'Built-in SearchBar Example',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          color: Color(0xFFA51414),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      custom.SearchBar(
                        hintText: 'Built-in SearchBar', // Set the placeholder text
                        backgroundColor: Colors.white, // White background for the search bar
                        iconColor: Color(0xFFA51414), // Red color for the search icon
                        borderRadius: 25.0, // Rounded corners
                      ),
                      SizedBox(height: 32),
                      // Text(
                      //   'Confirm Password Example',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontFamily: 'Product Sans',
                      //     color: Color(0xFFA51414),
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(height: 16),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Navigate to ConfirmPasswordScreen
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => ConfirmPasswordScreen(),
                      //       ),
                      //     );
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Color(0xFFA51414), // Red button color
                      //   ),
                      //   child: Text(
                      //     'Go to Confirm Password Screen',
                      //     style: TextStyle(
                      //       fontFamily: 'Product Sans',
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 24), // Added bottom padding
                    ],
                  ), //column
                ),
              );
            },
          ),
          if (_showSearchOverlay)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Material(
                color: Colors.black.withOpacity(0.5), // Semi-transparent background
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Search Products',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA51414),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Color(0xFFA51414)),
                            onPressed: _toggleSearchOverlay, // Close the overlay
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ProductSearch(), // Display the ProductSearch widget
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleSearchOverlay, // Toggle the search overlay
        backgroundColor: Color(0xFFA51414), // Red background for the button
        child: Icon(
          Icons.search,
          color: Colors.white, // White search icon
        ),
      ),
    );
  }
}

class SearchBuiltinPage extends StatelessWidget {
  const SearchBuiltinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Built-in'),
        backgroundColor: Color(0xFFA51414),
      ),
      body: Center(
        child: custom.SearchBar(
          hintText: 'Search here...',
          backgroundColor: Colors.white,
          iconColor: Color(0xFFA51414),
          borderRadius: 25.0,
        ),
      ),
    );
  }
}