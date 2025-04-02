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
                labelText: 'First name',
                hintText: 'Enter your first name',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Email
              GreyTextBox(
                nameController: emailController,
                labelText: 'Email',
                hintText: 'Enter your email',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Mobile
              GreyTextBox(
                nameController: mobileController,
                labelText: 'Mobile number',
                hintText: 'Enter your mobile number',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Company
              GreyTextBox(
                nameController: companyController,
                labelText: 'Company name',
                hintText: 'Enter your company name',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // GST No
              GreyTextBox(
                nameController: gstNoController,
                labelText: 'GST number',
                hintText: 'Enter your GST number',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Address 1
              GreyTextBox(
                nameController: address1Controller,
                labelText: 'Address line 1',
                hintText: 'Enter your address line 1',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Address 2
              GreyTextBox(
                nameController: address2Controller,
                labelText: 'Address line 2',
                hintText: 'Enter your address line 2',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Landmark
              GreyTextBox(
                nameController: landmarkController,
                labelText: 'Landmark',
                hintText: 'Enter your landmark',
                backgroundColor: Color(0xFFE4E8EC), // Grey background color
              ),

              SizedBox(height: 10), // Space between fields

              // Zip Code and State
              Row(
                children: [
                  Flexible(
                    child: GreyTextBox(
                      nameController: zipCodeController,
                      labelText: 'Zip code',
                      hintText: 'Enter your zip code',
                      backgroundColor:
                          Color(0xFFE4E8EC), // Grey background color
                    ),
                  ),
                  SizedBox(width: 30), // Padding between Zip Code and State
                  Flexible(
                    child: GreyTextBox(
                      nameController: stateController,
                      labelText: 'State',
                      hintText: 'Enter your state',
                      backgroundColor:
                          Color(0xFFE4E8EC), // Grey background color
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20), // Space between rows

              // City and Country
              Row(
                children: [
                  Flexible(
                    child: GreyTextBox(
                      nameController: cityController,
                      labelText: 'City',
                      hintText: 'Enter your city',
                      backgroundColor:
                          Color(0xFFE4E8EC), // Grey background color
                    ),
                  ),
                  SizedBox(width: 30), // Padding between City and Country
                  Flexible(
                    child: GreyTextBox(
                      nameController: countryController,
                      labelText: 'Country',
                      hintText: 'Enter your country',
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
  final String labelText; // Single parameter for both label and hint text
  final String hintText; // Single parameter for both label and hint text
  final double? width; // Optional width parameter
  final Color backgroundColor; // Background color parameter

  GreyTextBox({
    Key? key,
    required this.nameController,
    this.labelText = 'Name', // Default value for label and hint text
    this.hintText = 'Enter your name', // Default value for label and hint text
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
          labelText, // Use the single parameter for label text
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
              hintText: hintText, // Use the same parameter for hint text
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
