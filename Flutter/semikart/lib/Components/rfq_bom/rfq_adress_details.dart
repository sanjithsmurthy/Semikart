import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/red_button.dart';
import '../common/grey_text_box.dart';
import '../common/popup.dart'; // Import the CustomPopup

class RFQAddressDetails extends StatefulWidget {
  final String title;
  final String submitButtonText;
  final VoidCallback onSubmit;
  final String? initialAddress1;
  final String? initialAddress2;
  final Function(bool) onValidationChanged;
  final bool canSubmit;

  const RFQAddressDetails({
    Key? key,
    this.title = 'Address Details',
    this.submitButtonText = 'Submit',
    required this.onSubmit,
    this.initialAddress1,
    this.initialAddress2,
    required this.onValidationChanged,
    required this.canSubmit,
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

  final FocusNode firstNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode mobileFocus = FocusNode();
  final FocusNode companyFocus = FocusNode();
  final FocusNode gstNoFocus = FocusNode();
  final FocusNode address1Focus = FocusNode();
  final FocusNode address2Focus = FocusNode();
  final FocusNode landmarkFocus = FocusNode();
  final FocusNode zipCodeFocus = FocusNode();
  final FocusNode stateFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode countryFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    address1Controller =
        TextEditingController(text: widget.initialAddress1 ?? '');
    address2Controller =
        TextEditingController(text: widget.initialAddress2 ?? '');
    _validateFields();
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

    firstNameFocus.dispose();
    emailFocus.dispose();
    mobileFocus.dispose();
    companyFocus.dispose();
    gstNoFocus.dispose();
    address1Focus.dispose();
    address2Focus.dispose();
    landmarkFocus.dispose();
    zipCodeFocus.dispose();
    stateFocus.dispose();
    cityFocus.dispose();
    countryFocus.dispose();

    super.dispose();
  }

  void _validateFields() {
    String? errorMessage;

    if (firstNameController.text.isEmpty) {
      errorMessage = 'First name is required';
    } else if (emailController.text.isEmpty) {
      errorMessage = 'Email is required';
    } else if (!emailController.text.contains('@')) {
      errorMessage = 'Please enter a valid email';
    } else if (mobileController.text.isEmpty) {
      errorMessage = 'Mobile number is required';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(mobileController.text)) {
      errorMessage = 'Mobile number must contain only numbers';
    } else if (mobileController.text.length < 10) {
      errorMessage = 'Please enter a valid mobile number';
    } else if (address1Controller.text.isEmpty) {
      errorMessage = 'Address line 1 is required';
    } else if (address2Controller.text.isEmpty) {
      errorMessage = 'Address line 2 is required';
    } else if (landmarkController.text.isEmpty) {
      errorMessage = 'Landmark is required';
    } else if (zipCodeController.text.isEmpty) {
      errorMessage = 'Zip code is required';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(zipCodeController.text)) {
      errorMessage = 'Zip code must contain only numbers';
    } else if (zipCodeController.text.length < 6) {
      errorMessage = 'Please enter a valid zip code';
    } else if (stateController.text.isEmpty) {
      errorMessage = 'State is required';
    } else if (cityController.text.isEmpty) {
      errorMessage = 'City is required';
    } else if (countryController.text.isEmpty) {
      errorMessage = 'Country is required';
    }

    bool isValid = errorMessage == null;

    setState(() {
      _errorMessage = errorMessage;
      _isValid = isValid;
    });

    widget.onValidationChanged(isValid);
  }

  void _submitForm() async {
    if (_isValid) {
      widget.onSubmit();
    } else {
      // Use CustomPopup for error message
      await CustomPopup.show(
        context: context,
        title: 'Error',
        message: _errorMessage ?? 'Please fill all required fields correctly',
        buttonText: 'OK',
      );
    }
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
                  focusNode: firstNameFocus,
                  nextFocus: emailFocus,
                  cursorColor: const Color(0xFFA51414),
                  cursorWidth: 1.0,
                  selectionColor: const Color(0xFFA51414),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First name is required';
                    }
                    return null;
                  },
                  onChanged: (_) => _validateFields(),
                ),
                SizedBox(height: textBoxSpacing),
                GreyTextBox(
                  nameController: emailController,
                  text: 'Email*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocus,
                  nextFocus: mobileFocus,
                  cursorColor: const Color(0xFFA51414),
                  cursorWidth: 1.0,
                  selectionColor: const Color(0xFFA51414),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (_) => _validateFields(),
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
                  focusNode: mobileFocus,
                  nextFocus: companyFocus,
                  cursorColor: const Color(0xFFA51414),
                  cursorWidth: 1.0,
                  selectionColor: const Color(0xFFA51414),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile number is required';
                    }
                    if (value.length < 10) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                  onChanged: (_) => _validateFields(),
                ),
                SizedBox(height: textBoxSpacing),
                GreyTextBox(
                  nameController: companyController,
                  text: 'Company name',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  focusNode: companyFocus,
                  nextFocus: gstNoFocus,
                  cursorColor: const Color(0xFFA51414),
                  cursorWidth: 1.0,
                  selectionColor: const Color(0xFFA51414),
                  onChanged: (_) => _validateFields(),
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
                  focusNode: gstNoFocus,
                  nextFocus: address1Focus,
                  cursorColor: const Color(0xFFA51414),
                  cursorWidth: 1.0,
                  selectionColor: const Color(0xFFA51414),
                  onChanged: (_) => _validateFields(),
                ),
                SizedBox(height: textBoxSpacing),
                GreyTextBox(
                  nameController: address1Controller,
                  text: 'Address line 1*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  focusNode: address1Focus,
                  nextFocus: address2Focus,
                  cursorColor: const Color(0xFFA51414),
                  cursorWidth: 1.0,
                  selectionColor: const Color(0xFFA51414),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address line 1 is required';
                    }
                    return null;
                  },
                  onChanged: (_) => _validateFields(),
                ),
                SizedBox(height: textBoxSpacing),
                GreyTextBox(
                  nameController: address2Controller,
                  text: 'Address line 2*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  focusNode: address2Focus,
                  nextFocus: landmarkFocus,
                  cursorColor: const Color(0xFFA51414),
                  cursorWidth: 1.0,
                  selectionColor: const Color(0xFFA51414),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address line 2 is required';
                    }
                    return null;
                  },
                  onChanged: (_) => _validateFields(),
                ),
                SizedBox(height: textBoxSpacing),
                GreyTextBox(
                  nameController: landmarkController,
                  text: 'Landmark*',
                  backgroundColor: Color(0xFFE4E8EC),
                  labelFontSize: textBoxLabelFontSize,
                  textBoxHeight: textBoxHeight,
                  focusNode: landmarkFocus,
                  nextFocus: zipCodeFocus,
                  cursorColor: const Color(0xFFA51414),
                  cursorWidth: 1.0,
                  selectionColor: const Color(0xFFA51414),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Landmark is required';
                    }
                    return null;
                  },
                  onChanged: (_) => _validateFields(),
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
                        focusNode: zipCodeFocus,
                        nextFocus: stateFocus,
                        cursorColor: const Color(0xFFA51414),
                        cursorWidth: 1.0,
                        selectionColor: const Color(0xFFA51414),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Zip code is required';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Zip code must contain only numbers';
                          }
                          if (value.length < 6) {
                            return 'Please enter a valid zip code';
                          }
                          return null;
                        },
                        onChanged: (_) => _validateFields(),
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
                        focusNode: stateFocus,
                        nextFocus: cityFocus,
                        cursorColor: const Color(0xFFA51414),
                        cursorWidth: 1.0,
                        selectionColor: const Color(0xFFA51414),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'State is required';
                          }
                          return null;
                        },
                        onChanged: (_) => _validateFields(),
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
                        focusNode: cityFocus,
                        nextFocus: countryFocus,
                        cursorColor: const Color(0xFFA51414),
                        cursorWidth: 1.0,
                        selectionColor: const Color(0xFFA51414),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'City is required';
                          }
                          return null;
                        },
                        onChanged: (_) => _validateFields(),
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
                        focusNode: countryFocus,
                        cursorColor: const Color(0xFFA51414),
                        cursorWidth: 1.0,
                        selectionColor: const Color(0xFFA51414),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Country is required';
                          }
                          return null;
                        },
                        onChanged: (_) => _validateFields(),
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
                    onPressed: widget.canSubmit ? _submitForm : () {},
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
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final Function(String)? onChanged;
  final Color? cursorColor;
  final double? cursorWidth;
  final Color? selectionColor;

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
    this.focusNode,
    this.nextFocus,
    this.onChanged,
    this.cursorColor,
    this.cursorWidth,
    this.selectionColor,
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
            cursorColor: cursorColor ?? Colors.black,
            cursorWidth: cursorWidth ?? 1.0,
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
            focusNode: focusNode,
            onChanged: onChanged,
            onEditingComplete: () {
              if (nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              } else {
                FocusScope.of(context).unfocus();
              }
            },
          ),
        ),
      ],
    );
  }
}
