import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/red_button.dart';
import '../common/grey_text_box.dart';

class RFQAddressDetails extends StatefulWidget {
  final String title;
  final String submitButtonText;
  final VoidCallback onSubmit;
  final String? initialAddress1;
  final String? initialAddress2;
  final VoidCallback? onTextFieldFocused; // Add this line

  const RFQAddressDetails({
    Key? key,
    this.title = 'Address Details',
    this.submitButtonText = 'Submit',
    required this.onSubmit,
    this.initialAddress1,
    this.initialAddress2,
    this.onTextFieldFocused, // Add this line
  }) : super(key: key);

  @override
  State<RFQAddressDetails> createState() => _RFQAddressDetailsState();
}

class _RFQAddressDetailsState extends State<RFQAddressDetails> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController gstNoController = TextEditingController();
  late final TextEditingController address1Controller;
  late final TextEditingController address2Controller;
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    address1Controller =
        TextEditingController(text: widget.initialAddress1 ?? '');
    address2Controller =
        TextEditingController(text: widget.initialAddress2 ?? '');
  }

  @override
  void dispose() {
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

  void _submitForm() {
    // Validate all required fields
    if (firstNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        mobileController.text.isEmpty ||
        address1Controller.text.isEmpty ||
        address2Controller.text.isEmpty ||
        landmarkController.text.isEmpty ||
        zipCodeController.text.isEmpty ||
        stateController.text.isEmpty ||
        cityController.text.isEmpty ||
        countryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all requirement fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Validate mobile number is numeric
    if (!RegExp(r'^[0-9]+$').hasMatch(mobileController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mobile number must contain only numbers'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Validate zip code is numeric
    if (!RegExp(r'^[0-9]+$').hasMatch(zipCodeController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Zip code must contain only numbers'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    widget.onSubmit();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double titleFontSize = screenWidth * 0.05;
    final double sectionSpacing = screenWidth * 0.04;
    final double textBoxSpacing = screenWidth * 0.025;
    final double rowSpacing = screenWidth * 0.025;
    final double textBoxWidth = screenWidth * 0.9;
    final double reCaptchaHeight = screenHeight * 0.06;
    final double reCaptchaFontSize = screenWidth * 0.035;
    final double submitButtonSpacing = screenWidth * 0.05;
    final double textBoxLabelFontSize = screenWidth * 0.0325;
    final double textBoxHeight = screenHeight * 0.05;
    final double rowHorizontalSpacing = screenWidth * 0.075;

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(sectionSpacing),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: sectionSpacing),
                GreyTextBox(
                  nameController: firstNameController,
                  text: 'First name*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First name is required';
                    }
                    return null;
                  },
                  onTap: widget.onTextFieldFocused, // Add this line
                ),
                SizedBox(height: textBoxSpacing),
                GreyTextBox(
                  nameController: emailController,
                  text: 'Email*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onTap: widget.onTextFieldFocused, // Add this line
                ),
                SizedBox(height: textBoxSpacing),
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
                      return 'Mobile number is required';
                    }
                    if (value.length < 10) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                  onTap: widget.onTextFieldFocused, // Add this line
                ),
                SizedBox(height: textBoxSpacing),
                GreyTextBox(
                  nameController: companyController,
                  text: 'Company name',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  onTap: widget.onTextFieldFocused, // Add this line
                ),
                SizedBox(height: textBoxSpacing),
                GreyTextBox(
                  nameController: gstNoController,
                  text: 'GST number',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onTap: widget.onTextFieldFocused, // Add this line
                ),
                SizedBox(height: textBoxSpacing),
                GreyTextBox(
                  nameController: address1Controller,
                  text: 'Address line 1*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address line 1 is required';
                    }
                    return null;
                  },
                  onTap: widget.onTextFieldFocused, // Add this line
                ),
                SizedBox(height: textBoxSpacing),
                GreyTextBox(
                  nameController: address2Controller,
                  text: 'Address line 2*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address line 2 is required';
                    }
                    return null;
                  },
                  onTap: widget.onTextFieldFocused, // Add this line
                ),
                SizedBox(height: textBoxSpacing),
                GreyTextBox(
                  nameController: landmarkController,
                  text: 'Landmark*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Landmark is required';
                    }
                    return null;
                  },
                  onTap: widget.onTextFieldFocused, // Add this line
                ),
                SizedBox(height: textBoxSpacing),
                Row(
                  children: [
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
                            return 'Zip code is required';
                          }
                          if (value.length < 6) {
                            return 'Please enter a valid zip code';
                          }
                          return null;
                        },
                        onTap: widget.onTextFieldFocused, // Add this line
                      ),
                    ),
                    SizedBox(width: rowHorizontalSpacing),
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
                            return 'State is required';
                          }
                          return null;
                        },
                        onTap: widget.onTextFieldFocused, // Add this line
                      ),
                    ),
                  ],
                ),
                SizedBox(height: rowSpacing),
                Row(
                  children: [
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
                            return 'City is required';
                          }
                          return null;
                        },
                        onTap: widget.onTextFieldFocused, // Add this line
                      ),
                    ),
                    SizedBox(width: rowHorizontalSpacing),
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
                            return 'Country is required';
                          }
                          return null;
                        },
                        onTap: widget.onTextFieldFocused, // Add this line
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sectionSpacing),
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
                SizedBox(height: submitButtonSpacing),
                Center(
                  child: RedButton(
                    label: widget.submitButtonText,
                    onPressed: _submitForm,
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
  final String text;
  final double? width;
  final Color backgroundColor;
  final double labelFontSize;
  final double textBoxHeight;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final VoidCallback? onTap; // Add this line

  const GreyTextBox({
    Key? key,
    required this.nameController,
    this.text = 'Name',
    this.width,
    this.backgroundColor = const Color(0xFFE4E8EC),
    required this.labelFontSize,
    required this.textBoxHeight,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onTap, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: labelFontSize,
            color: Color(0xFFA51414),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: width ?? screenWidth * 0.9,
          height: textBoxHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(9),
          ),
          child: TextFormField(
            cursorColor: Colors.black,
            controller: nameController,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: text,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              errorStyle:
                  TextStyle(height: 0), // Hide the error message in the field
            ),
            validator: validator,
            onTap: onTap, // Add this line
          ),
        ),
      ],
    );
  }
}