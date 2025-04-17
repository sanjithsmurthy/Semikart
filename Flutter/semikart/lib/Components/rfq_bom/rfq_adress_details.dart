import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for TextInputType
import '../common/red_button.dart';
import '../common/grey_text_box.dart';

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

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

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
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    // Dynamic dimensions based on screen width
    final double titleFontSize = screenWidth * 0.05; // 5% of screen width
    final double sectionSpacing = screenWidth * 0.04; // 4% of screen width
    final double textBoxSpacing = screenWidth * 0.025; // 2.5% of screen width
    final double rowSpacing = screenWidth * 0.025; // 2.5% of screen width
    final double textBoxWidth = screenWidth * 0.9; // 90% of screen width
    final double reCaptchaHeight = screenHeight * 0.06; // 6% of screen height
    final double reCaptchaFontSize =
        screenWidth * 0.035; // 3.5% of screen width
    final double submitButtonSpacing = screenWidth * 0.05; // 5% of screen width
    final double textBoxLabelFontSize =
        screenWidth * 0.0325; // 3.25% of screen width
    final double textBoxHeight = screenHeight * 0.05; // 5% of screen height
    final double rowHorizontalSpacing =
        screenWidth * 0.075; // 7.5% of screen width

    return Container(
      color: Colors.white, // Set the background color to white
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(sectionSpacing),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Changed to black
                  ),
                ),
                SizedBox(height: sectionSpacing), // Space below the title

                // First Name
                GreyTextBox(
                  nameController: firstNameController,
                  text: 'First name*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: textBoxSpacing), // Space between fields

                // Email
                GreyTextBox(
                  nameController: emailController,
                  text: 'Email*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                SizedBox(height: textBoxSpacing), // Space between fields

                // Mobile
                GreyTextBox(
                  nameController: mobileController,
                  text: 'Mobile number*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (value.length < 10) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                ),

                SizedBox(height: textBoxSpacing), // Space between fields

                // Company
                GreyTextBox(
                  nameController: companyController,
                  text: 'Company name',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                ),

                SizedBox(height: textBoxSpacing), // Space between fields

                // GST No
                GreyTextBox(
                  nameController: gstNoController,
                  text: 'GST number',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),

                SizedBox(height: textBoxSpacing), // Space between fields

                // Address 1
                GreyTextBox(
                  nameController: address1Controller,
                  text: 'Address line 1*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address line 1';
                    }
                    return null;
                  },
                ),

                SizedBox(height: textBoxSpacing), // Space between fields

                // Address 2
                GreyTextBox(
                  nameController: address2Controller,
                  text: 'Address line 2*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address line 2';
                    }
                    return null;
                  },
                ),

                SizedBox(height: textBoxSpacing), // Space between fields

                // Landmark
                GreyTextBox(
                  nameController: landmarkController,
                  text: 'Landmark*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your landmark';
                    }
                    return null;
                  },
                ),

                SizedBox(height: textBoxSpacing), // Space between fields

                // Zip Code and State
                Row(
                  children: [
                    // Zip Code
                    Expanded(
                      flex: 1,
                      child: GreyTextBox(
                        nameController: zipCodeController,
                        text: 'Zip code*',
                        backgroundColor: Color(0xFFE4E8EC),
                        labelFontSize: textBoxLabelFontSize,
                        textBoxHeight: textBoxHeight,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your zip code';
                          }
                          if (value.length < 6) {
                            return 'Please enter a valid zip code';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                        width:
                            rowHorizontalSpacing), // Match the spacing between Quantity and Price
                    // State
                    Expanded(
                      flex: 1,
                      child: GreyTextBox(
                        nameController: stateController,
                        text: 'State*',
                        backgroundColor: Color(0xFFE4E8EC),
                        labelFontSize: textBoxLabelFontSize,
                        textBoxHeight: textBoxHeight,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your state';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: rowSpacing), // Space between rows

                // City and Country
                Row(
                  children: [
                    // City
                    Expanded(
                      flex: 1,
                      child: GreyTextBox(
                        nameController: cityController,
                        text: 'City*',
                        backgroundColor: Color(0xFFE4E8EC),
                        labelFontSize: textBoxLabelFontSize,
                        textBoxHeight: textBoxHeight,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                        width:
                            rowHorizontalSpacing), // Match the spacing between Quantity and Price
                    // Country
                    Expanded(
                      flex: 1,
                      child: GreyTextBox(
                        nameController: countryController,
                        text: 'Country*',
                        backgroundColor: Color(0xFFE4E8EC),
                        labelFontSize: textBoxLabelFontSize,
                        textBoxHeight: textBoxHeight,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your country';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: sectionSpacing), // Space before reCAPTCHA

                // reCAPTCHA Placeholder
                Container(
                  height: reCaptchaHeight,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "I'm not a robot",
                      style: TextStyle(
                        fontSize: reCaptchaFontSize,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                    height: submitButtonSpacing), // Space before Submit button

                // Submit Button
                Center(
                  child: RedButton(
                    label: widget.submitButtonText,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSubmit();
                      }
                    },
                  ),
                ),
              ],
            ),
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
  final double labelFontSize; // Font size for the label
  final double textBoxHeight; // Height for the text box
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  GreyTextBox({
    Key? key,
    required this.nameController,
    this.text = 'Name', // Default value for label and hint text
    this.width, // Optional width
    this.backgroundColor =
        const Color(0xFFE4E8EC), // Default grey background color
    required this.labelFontSize, // Font size for the label
    required this.textBoxHeight, // Height for the text box
    this.keyboardType,
    this.inputFormatters,
    this.validator,
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
            fontSize: labelFontSize,
            color: Color(0xFFA51414), // Adjust the color as needed
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: width ??
              screenWidth *
                  0.9, // Default to 90% of screen width if width is not provided
          height: textBoxHeight,
          decoration: BoxDecoration(
            color: backgroundColor, // Use the customizable background color
            borderRadius: BorderRadius.circular(9),
          ),
          child: TextFormField(
            cursorColor: Colors.black, // Set the cursor color to black
            controller: nameController,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: text, // Use the same parameter for hint text
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
