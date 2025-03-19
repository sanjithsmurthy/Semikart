import 'package:flutter/material.dart';
import '../Commons/custom_text_field.dart';
import '../Commons/textfield_dropdown.dart';
import '../Commons/red_button.dart';
import '../Commons/inactive_button.dart';  // Add this import

class TestLayoutSanjana extends StatefulWidget {
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
                'Button States',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Product Sans',
                  color: Color(0xFFA51414),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: RedButton(
                  label: "Active Button",
                  onPressed: () {
                    print('Button pressed!');
                  },
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: InactiveButton(
                  label: "Inactive Button",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}