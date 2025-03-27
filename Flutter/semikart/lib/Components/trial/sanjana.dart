import 'package:flutter/material.dart';
import '../Commons/custom_text_field.dart';
import '../Commons/textfield_dropdown.dart';
import '../Commons/red_button.dart';
import '../Commons/inactive_red_button.dart';
import '../Commons/white_button.dart';
import '../Commons/track_order.dart';
import '../Commons/captcha.dart';  // Add this import
import '../Commons/signinwith_google.dart';
import '../Commons/two_radios.dart';  // Add this import with other imports
import '../Commons/RFQ_CTA.dart';  // Add this with other imports
import '../Commons/cartempty.dart';  // Add this with other imports
import '../Commons/order_view.dart';  // Add this with other imports
import '../Commons/profilepic.dart';  // Add this with other imports

class TestLayoutSanjana extends StatefulWidget {
  const TestLayoutSanjana({super.key});

  @override
  State<TestLayoutSanjana> createState() => _TestLayoutSanjanaState();
}

class _TestLayoutSanjanaState extends State<TestLayoutSanjana> {
  final TextEditingController _emailController = TextEditingController();
  String? _selectedState;
  bool _isCaptchaValid = false;  // Add this state variable
  int _selectedRadio = 0;  // Add this state variable

  @override
  void dispose() {
    _emailController.dispose();
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Component Testing',
          style: TextStyle(fontFamily: 'Product Sans'),
        ),
        backgroundColor: Color(0xFFA51414),
      ),
      body: LayoutBuilder(
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
                            variant: 'big',
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
                  SizedBox(height: 16),
                  TwoRadioButtons(
                    firstLabel: 'Option One',
                    secondLabel: 'Option Two',
                    initialSelection: _selectedRadio,
                    radioWidth: buttonWidth,
                    radioHeight: 48,
                    onSelectionChanged: (selected) {
                      setState(() {
                        _selectedRadio = selected;
                        print('Selected radio option: ${selected == 0 ? "One" : "Two"}');
                      });
                    },
                  ),
                  SizedBox(height: 32),
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
                    currentStep: 2,  // Shows progress up to Contacted Supplier
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
                      onEditPressed: () {
                        print('Edit profile picture pressed');
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
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: OrderView(),
                  ),
                  SizedBox(height: 24), // Added bottom padding
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

