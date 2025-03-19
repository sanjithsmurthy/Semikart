import 'package:flutter/material.dart';
import '../Commons/custom_text_field.dart';
import '../Commons/textfield_dropdown.dart';
import '../Commons/red_button.dart';
import '../Commons/inactive_red_button.dart';
import '../Commons/white_button.dart';
import '../Commons/track_order.dart';
import '../Commons/captcha.dart';  // Add this import
import '../Commons/signinwith_google.dart';

class TestLayoutSanjana extends StatefulWidget {
  @override
  State<TestLayoutSanjana> createState() => _TestLayoutSanjanaState();
}

class _TestLayoutSanjanaState extends State<TestLayoutSanjana> {
  final TextEditingController _emailController = TextEditingController();
  String? _selectedState;
  bool _isCaptchaValid = false;  // Add this state variable

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<OrderStep> orderSteps = [
      OrderStep(
        title: 'Order Confirmed',
        location: 'Your order has been placed successfully',
        icon: Icons.check_circle_outline,
        timestamp: '19 Mar, 2024 10:30 AM',
      ),
      OrderStep(
        title: 'Shipped',
        location: 'Your order is on the way',
        icon: Icons.local_shipping_outlined,
        timestamp: null,
      ),
      OrderStep(
        title: 'Out for Delivery',
        location: 'Your order will be delivered today',
        icon: Icons.delivery_dining_outlined,
        timestamp: null,
      ),
      OrderStep(
        title: 'Delivered',
        location: 'Order has been delivered',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
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
                    RedButton(
                      label: "Active Button",
                      onPressed: () {
                        print('Red button pressed!');
                      },
                    ),
                    SizedBox(height: 16),
                    InactiveButton(
                      label: "Inactive Button",
                    ),
                    SizedBox(height: 16),
                    WhiteButton(
                      label: "White Button",
                      onPressed: () {
                        print('White button pressed!');
                      },
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
                currentStep: 2,  // Shows progress up to Order Shipped
              ),
            ],
          ),
        ),
      ),
    );
  }
}