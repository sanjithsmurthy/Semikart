import 'package:flutter/material.dart';
import '../Commons/red_button.dart'; // Import the RedButton widget
import '../Commons/grey_text_box.dart'; // Import the GreyTextBox widget

class RFQAddressDetails extends StatefulWidget {
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
  State<RFQAddressDetails> createState() => _RFQAddressDetailsState();
}

class _RFQAddressDetailsState extends State<RFQAddressDetails> {
  // Controllers for each text field
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController gstNoController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  void dispose() {
    // Dispose all controllers
    firstNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    companyController.dispose();
    gstNoController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    landmarkController.dispose();
    zipCodeController.dispose();
    stateController.dispose();
    cityController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width

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
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Changed to black
                ),
              ),
              SizedBox(height: 20), // Space below the title

              // First Name
              GreyTextBox(
                nameController: firstNameController,
                text: 'First name',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Email
              GreyTextBox(
                nameController: emailController,
                text: 'Email',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Mobile
              GreyTextBox(
                nameController: mobileController,
                text: 'Mobile number',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Company
              GreyTextBox(
                nameController: companyController,
                text: 'Company name',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // GST No
              GreyTextBox(
                nameController: gstNoController,
                text: 'GST number',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Address 1
              GreyTextBox(
                nameController: address1Controller,
                text: 'Address line 1',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Address 2
              GreyTextBox(
                nameController: address2Controller,
                text: 'Address line 2',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Landmark
              GreyTextBox(
                nameController: landmarkController,
                text: 'Landmark',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Zip Code and State
              Row(
                children: [
                  Flexible(
                    child: GreyTextBox(
                      nameController: zipCodeController,
                      text: 'Zip code',
                      backgroundColor:
                          Color(0xFFE4E8EC), // Grey background color
                    ),
                  ),
                  SizedBox(width: 10), // Adjusted padding to match other fields
                  Flexible(
                    child: GreyTextBox(
                      nameController: stateController,
                      text: 'State',
                      backgroundColor:
                          Color(0xFFE4E8EC), // Grey background color
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10), // Space between rows

              // City and Country
              Row(
                children: [
                  Flexible(
                    child: GreyTextBox(
                      nameController: cityController,
                      text: 'City',
                      backgroundColor:
                          Color(0xFFE4E8EC), // Grey background color
                    ),
                  ),
                  SizedBox(width: 10), // Adjusted padding to match other fields
                  Flexible(
                    child: GreyTextBox(
                      nameController: countryController,
                      text: 'Country',
                      backgroundColor:
                          Color(0xFFE4E8EC), // Grey background color
                    ),
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
                  label: widget.submitButtonText,
                  onPressed: widget.onSubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GreyTextBox extends StatelessWidget {
  final TextEditingController nameController;
  final String text; // Single parameter for both label and hint text
  final double? width; // Optional width parameter
  final Color backgroundColor; // Background color parameter

  GreyTextBox({
    Key? key,
    required this.nameController,
    this.text = 'Name', // Default value for label and hint text
    this.width, // Optional width
    this.backgroundColor =
        const Color(0xFFE4E8EC), // Default grey background color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text, // Use the single parameter for label text
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFFA51414), // Adjust the color as needed
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: width ??
              screenWidth *
                  0.9, // Default to 90% of screen width if width is not provided
          height: 41.54,
          decoration: BoxDecoration(
            color: backgroundColor, // Use the customizable background color
            borderRadius: BorderRadius.circular(9),
          ),
          child: TextField(
            cursorColor: Colors.black, // Set the cursor color to black
            controller: nameController,
            decoration: InputDecoration(
              hintText: text, // Use the same parameter for hint text
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }
}
