import 'package:flutter/material.dart';
import '../Commons/red_button.dart'; // Import the RedButton widget

class RFQAddressDetails extends StatelessWidget {
  final String title;
  final String submitButtonText;
  final VoidCallback onSubmit;

  const RFQAddressDetails({
    super.key,
    this.title = 'Address Details',
    this.submitButtonText = 'Submit',
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set the background color to white
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Changed to black
                ),
              ),
              SizedBox(height: 20), // Space below the title

              // First Name
              _buildTextField(label: 'First Name'),

              // Email
              _buildTextField(label: 'Email'),

              // Mobile
              _buildTextField(label: 'Mobile'),

              // Company
              _buildTextField(label: 'Company'),

              // GST No
              _buildTextField(label: 'GST No'),

              // Address 1
              _buildTextField(label: 'Address 1'),

              // Address 2
              _buildTextField(label: 'Address 2'),

              // Landmark
              _buildTextField(label: 'Landmark'),

              // Zip Code and State
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(label: 'Zip Code'),
                  ),
                  SizedBox(width: 10), // Space between fields
                  Expanded(
                    child: _buildTextField(label: 'State'),
                  ),
                ],
              ),

              // City and Country
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(label: 'City'),
                  ),
                  SizedBox(width: 10), // Space between fields
                  Expanded(
                    child: _buildTextField(label: 'Country'),
                  ),
                ],
              ),

              SizedBox(height: 20), // Space before reCAPTCHA

              // reCAPTCHA Placeholder
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    "I'm not a robot",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20), // Space before Submit button

              // Submit Button
              Center(
                child: RedButton(
                  label: submitButtonText,
                  onPressed: onSubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a text field
  Widget _buildTextField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black, // Changed to black
          ),
        ),
        SizedBox(height: 5), // Space between label and text field
        SizedBox(
          height: 35, // Set height for the text field
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Set corner radius
                borderSide: BorderSide.none, // Remove the border
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              filled: true,
              fillColor: Color(0xFFF9F9F9), // Background color
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        SizedBox(height: 15), // Space below the text field
      ],
    );
  }
}
