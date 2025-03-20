import 'package:flutter/material.dart';
import '../Commons/custom_text_field.dart';
import '../Commons/textfield_dropdown.dart';
import '../Commons/red_button.dart';
import '../Commons/inactive_red_button.dart';
import '../Commons/white_button.dart';  // Add this import

class TestLayoutSanjana extends StatefulWidget {
  const TestLayoutSanjana({super.key});

  @override
  State<TestLayoutSanjana> createState() => _TestLayoutSanjanaState();
}

class _TestLayoutSanjanaState extends State<TestLayoutSanjana> {
  final TextEditingController _emailController = TextEditingController();
  String? _selectedState;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
      ),
    );
  }
}