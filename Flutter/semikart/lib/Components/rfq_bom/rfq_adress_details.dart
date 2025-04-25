import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/red_button.dart';
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
    // Dispose controllers
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

    // Dispose focus nodes
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

    // --- Validation Logic (unchanged) ---
    if (firstNameController.text.trim().isEmpty) {
      errorMessage = 'First name is required';
    } else if (emailController.text.trim().isEmpty) {
      errorMessage = 'Email is required';
    } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(emailController.text.trim())) {
      errorMessage = 'Please enter a valid email';
    } else if (mobileController.text.trim().isEmpty) {
      errorMessage = 'Mobile number is required';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(mobileController.text.trim())) {
      // This check might be redundant with input formatter but good for safety
      errorMessage = 'Mobile number must contain only numbers';
    } else if (mobileController.text.trim().length < 10) {
      errorMessage = 'Please enter a valid mobile number';
    } else if (address1Controller.text.trim().isEmpty) {
      errorMessage = 'Address line 1 is required';
    } else if (address2Controller.text.trim().isEmpty) {
      errorMessage = 'Address line 2 is required';
    } else if (landmarkController.text.trim().isEmpty) {
      errorMessage = 'Landmark is required';
    } else if (zipCodeController.text.trim().isEmpty) {
      errorMessage = 'Zip code is required';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(zipCodeController.text.trim())) {
      // Redundant with input formatter
      errorMessage = 'Zip code must contain only numbers';
    } else if (zipCodeController.text.trim().length < 6) {
      errorMessage = 'Please enter a valid zip code';
    } else if (stateController.text.trim().isEmpty) {
      errorMessage = 'State is required';
    } else if (cityController.text.trim().isEmpty) {
      errorMessage = 'City is required';
    } else if (countryController.text.trim().isEmpty) {
      errorMessage = 'Country is required';
    }
    // --- End Validation Logic ---


    bool isValid = errorMessage == null;

    if (mounted) {
      setState(() {
        _errorMessage = errorMessage;
        _isValid = isValid;
      });
    }

    widget.onValidationChanged(isValid);
  }

  void _submitForm() async {
    _validateFields(); // Re-validate before submission

    if (_isValid && widget.canSubmit) { // Check canSubmit flag as well
      widget.onSubmit();
    } else if (!_isValid) { // Only show error popup if validation failed
      if (!mounted) return;
      await CustomPopup.show(
        context: context,
        title: 'Error',
        message: _errorMessage ?? 'Please fill all required fields correctly',
        buttonText: 'OK',
      );
    }
    // If !_isValid is false but widget.canSubmit is false, do nothing (button is likely disabled)
  }

  @override
  Widget build(BuildContext context) {
    // --- Responsive Scaling Setup ---
    const double referenceWidth = 412.0;
    const double referenceHeight = 917.0; // Keep reference height if needed for specific elements

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate scale factors (primarily use width scale)
    final double scaleWidth = screenWidth / referenceWidth;
    // final double scaleHeight = screenHeight / referenceHeight; // Use if height scaling is needed

    // Use scaleWidth for most elements to maintain horizontal proportions
    final double scale = scaleWidth;
    // --- End Responsive Scaling Setup ---

    // --- Scaled Dimensions ---
    // Base values are chosen relative to the reference width (412px)
    final double titleFontSize = 20.0 * scale; // e.g., 20px on reference width
    final double sectionSpacing = 16.0 * scale; // e.g., 16px
    final double textBoxSpacing = 10.0 * scale; // e.g., 10px
    final double rowSpacing = 10.0 * scale; // e.g., 10px
    // GreyTextBox width will be handled internally, but pass scaled height/font
    final double reCaptchaHeight = 50.0 * scale; // e.g., 50px height
    final double reCaptchaFontSize = 14.0 * scale; // e.g., 14px font
    final double submitButtonSpacing = 20.0 * scale; // e.g., 20px
    final double textBoxLabelFontSize = 13.5 * scale; // e.g., 13.5px font
    // Scale height based on reference height or a fixed aspect ratio * scaleWidth
    final double textBoxHeight = 45.0 * scale; // e.g., 45px height, scales with width
    final double rowHorizontalSpacing = 16.0 * scale; // e.g., 16px horizontal space in rows
    // --- End Scaled Dimensions ---

    const Color primaryColor = Color(0xFFA51414);
    const Color textBoxBackgroundColor = Color(0xFFE4E8EC);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          // Use scaled padding
          padding: EdgeInsets.symmetric(horizontal: sectionSpacing, vertical: sectionSpacing),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: titleFontSize, // Scaled
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: sectionSpacing), // Scaled

                // --- Form Fields ---
                GreyTextBox(
                  nameController: firstNameController,
                  text: 'First name*',
                  backgroundColor: textBoxBackgroundColor,
                  labelFontSize: textBoxLabelFontSize, // Scaled
                  textBoxHeight: textBoxHeight, // Scaled
                  focusNode: firstNameFocus,
                  nextFocus: emailFocus,
                  cursorColor: primaryColor,
                  selectionHandleColor: primaryColor,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'First name is required';
                    }
                    return null;
                  },
                  onChanged: (_) => _validateFields(),
                  scaleFactor: scale, // Pass scale factor
                ),
                SizedBox(height: textBoxSpacing), // Scaled
                GreyTextBox(
                  nameController: emailController,
                  text: 'Email*',
                  backgroundColor: textBoxBackgroundColor,
                  labelFontSize: textBoxLabelFontSize, // Scaled
                  textBoxHeight: textBoxHeight, // Scaled
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocus,
                  nextFocus: mobileFocus,
                  cursorColor: primaryColor,
                  selectionHandleColor: primaryColor,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (_) => _validateFields(),
                  scaleFactor: scale, // Pass scale factor
                ),
                SizedBox(height: textBoxSpacing), // Scaled
                GreyTextBox(
                  nameController: mobileController,
                  text: 'Mobile number*',
                  backgroundColor: textBoxBackgroundColor,
                  labelFontSize: textBoxLabelFontSize, // Scaled
                  textBoxHeight: textBoxHeight, // Scaled
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)], // Limit length
                  focusNode: mobileFocus,
                  nextFocus: companyFocus,
                  cursorColor: primaryColor,
                  selectionHandleColor: primaryColor,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Mobile number is required';
                    }
                    if (value.trim().length < 10) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                  onChanged: (_) => _validateFields(),
                  scaleFactor: scale, // Pass scale factor
                ),
                SizedBox(height: textBoxSpacing), // Scaled
                GreyTextBox(
                  nameController: companyController,
                  text: 'Company name',
                  backgroundColor: textBoxBackgroundColor,
                  labelFontSize: textBoxLabelFontSize, // Scaled
                  textBoxHeight: textBoxHeight, // Scaled
                  focusNode: companyFocus,
                  nextFocus: gstNoFocus,
                  cursorColor: primaryColor,
                  selectionHandleColor: primaryColor,
                  onChanged: (_) => _validateFields(),
                  scaleFactor: scale, // Pass scale factor
                ),
                SizedBox(height: textBoxSpacing), // Scaled
                GreyTextBox(
                  nameController: gstNoController,
                  text: 'GST number',
                  backgroundColor: textBoxBackgroundColor,
                  labelFontSize: textBoxLabelFontSize, // Scaled
                  textBoxHeight: textBoxHeight, // Scaled
                  focusNode: gstNoFocus,
                  nextFocus: address1Focus,
                  cursorColor: primaryColor,
                  selectionHandleColor: primaryColor,
                  onChanged: (_) => _validateFields(),
                  scaleFactor: scale, // Pass scale factor
                ),
                SizedBox(height: textBoxSpacing), // Scaled
                GreyTextBox(
                  nameController: address1Controller,
                  text: 'Address line 1*',
                  backgroundColor: textBoxBackgroundColor,
                  labelFontSize: textBoxLabelFontSize, // Scaled
                  textBoxHeight: textBoxHeight, // Scaled
                  focusNode: address1Focus,
                  nextFocus: address2Focus,
                  cursorColor: primaryColor,
                  selectionHandleColor: primaryColor,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Address line 1 is required';
                    }
                    return null;
                  },
                  onChanged: (_) => _validateFields(),
                  scaleFactor: scale, // Pass scale factor
                ),
                SizedBox(height: textBoxSpacing), // Scaled
                GreyTextBox(
                  nameController: address2Controller,
                  text: 'Address line 2*',
                  backgroundColor: textBoxBackgroundColor,
                  labelFontSize: textBoxLabelFontSize, // Scaled
                  textBoxHeight: textBoxHeight, // Scaled
                  focusNode: address2Focus,
                  nextFocus: landmarkFocus,
                  cursorColor: primaryColor,
                  selectionHandleColor: primaryColor,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Address line 2 is required';
                    }
                    return null;
                  },
                  onChanged: (_) => _validateFields(),
                  scaleFactor: scale, // Pass scale factor
                ),
                SizedBox(height: textBoxSpacing), // Scaled
                GreyTextBox(
                  nameController: landmarkController,
                  text: 'Landmark*',
                  backgroundColor: textBoxBackgroundColor,
                  labelFontSize: textBoxLabelFontSize, // Scaled
                  textBoxHeight: textBoxHeight, // Scaled
                  focusNode: landmarkFocus,
                  nextFocus: zipCodeFocus,
                  cursorColor: primaryColor,
                  selectionHandleColor: primaryColor,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Landmark is required';
                    }
                    return null;
                  },
                  onChanged: (_) => _validateFields(),
                  scaleFactor: scale, // Pass scale factor
                ),
                SizedBox(height: rowSpacing), // Scaled

                // --- Row for Zip Code and State ---
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GreyTextBox(
                        nameController: zipCodeController,
                        text: 'Zip code*',
                        backgroundColor: textBoxBackgroundColor,
                        labelFontSize: textBoxLabelFontSize, // Scaled
                        textBoxHeight: textBoxHeight, // Scaled
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        focusNode: zipCodeFocus,
                        nextFocus: stateFocus,
                        cursorColor: primaryColor,
                        selectionHandleColor: primaryColor,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Zip code is required';
                          }
                          if (value.trim().length < 6) {
                            return 'Please enter a valid zip code';
                          }
                          return null;
                        },
                        onChanged: (_) => _validateFields(),
                        scaleFactor: scale, // Pass scale factor
                      ),
                    ),
                    SizedBox(width: rowHorizontalSpacing), // Scaled
                    Expanded(
                      child: GreyTextBox(
                        nameController: stateController,
                        text: 'State*',
                        backgroundColor: textBoxBackgroundColor,
                        labelFontSize: textBoxLabelFontSize, // Scaled
                        textBoxHeight: textBoxHeight, // Scaled
                        focusNode: stateFocus,
                        nextFocus: cityFocus,
                        cursorColor: primaryColor,
                        selectionHandleColor: primaryColor,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'State is required';
                          }
                          return null;
                        },
                        onChanged: (_) => _validateFields(),
                        scaleFactor: scale, // Pass scale factor
                      ),
                    ),
                  ],
                ),
                SizedBox(height: rowSpacing), // Scaled

                // --- Row for City and Country ---
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GreyTextBox(
                        nameController: cityController,
                        text: 'City*',
                        backgroundColor: textBoxBackgroundColor,
                        labelFontSize: textBoxLabelFontSize, // Scaled
                        textBoxHeight: textBoxHeight, // Scaled
                        focusNode: cityFocus,
                        nextFocus: countryFocus,
                        cursorColor: primaryColor,
                        selectionHandleColor: primaryColor,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'City is required';
                          }
                          return null;
                        },
                        onChanged: (_) => _validateFields(),
                        scaleFactor: scale, // Pass scale factor
                      ),
                    ),
                    SizedBox(width: rowHorizontalSpacing), // Scaled
                    Expanded(
                      child: GreyTextBox(
                        nameController: countryController,
                        text: 'Country*',
                        backgroundColor: textBoxBackgroundColor,
                        labelFontSize: textBoxLabelFontSize, // Scaled
                        textBoxHeight: textBoxHeight, // Scaled
                        focusNode: countryFocus,
                        cursorColor: primaryColor,
                        selectionHandleColor: primaryColor,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Country is required';
                          }
                          return null;
                        },
                        onChanged: (_) => _validateFields(),
                        scaleFactor: scale, // Pass scale factor
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sectionSpacing), // Scaled

                // --- Placeholder for reCAPTCHA ---
                Container(
                  height: reCaptchaHeight, // Scaled
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(5 * scale), // Scaled radius
                  ),
                  child: Center(
                    child: Text(
                      "I'm not a robot (Placeholder)",
                      style: TextStyle(
                        fontSize: reCaptchaFontSize, // Scaled
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: submitButtonSpacing), // Scaled

                // --- Submit Button ---
                Center(
                  child: RedButton(
                    label: widget.submitButtonText,
                    onPressed: widget.canSubmit ? _submitForm : () {}, // Keep existing logic
                    // Pass scaled font size to RedButton if it supports it
                    // Assuming RedButton scales internally or accepts fontSize
                    // fontSize: 16.0 * scale, // Example if RedButton needs it
                  ),
                ),
                SizedBox(height: sectionSpacing), // Scaled bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// --- GreyTextBox Widget (Modified for Scaling) ---
class GreyTextBox extends StatelessWidget {
  final TextEditingController nameController;
  final String text;
  final double? width; // Keep optional width override
  final Color backgroundColor;
  final double labelFontSize; // Now receives scaled value
  final double textBoxHeight; // Now receives scaled value
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final Function(String)? onChanged;
  final Color? cursorColor;
  final double? cursorWidth;
  final Color? selectionColor;
  final Color? selectionHandleColor;
  final double scaleFactor; // Receive the scale factor

  const GreyTextBox({
    Key? key,
    required this.nameController,
    required this.text,
    this.width,
    this.backgroundColor = const Color(0xFFE4E8EC),
    required this.labelFontSize, // Expect scaled value
    required this.textBoxHeight, // Expect scaled value
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.nextFocus,
    this.onChanged,
    this.cursorColor,
    this.cursorWidth = 1.5, // Base cursor width (could also scale if desired)
    this.selectionColor,
    this.selectionHandleColor,
    required this.scaleFactor, // Require scale factor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the default theme color
    const Color defaultThemeColor = Color(0xFFA51414);
    const double referenceWidth = 412.0; // Reference width for default calculation

    // Determine effective colors
    final Color effectiveHandleColor = selectionHandleColor ?? defaultThemeColor;
    final Color effectiveCursorColor = cursorColor ?? defaultThemeColor;
    final Color effectiveSelectionColor = selectionColor ?? effectiveHandleColor.withOpacity(0.4);

    // Calculate default width based on reference and scale factor if not overridden
    final double effectiveWidth = width ?? (referenceWidth * 0.9 * scaleFactor);
    // Scaled internal padding/radius
    final double internalHPadding = 10.0 * scaleFactor;
    final double borderRadius = 8.0 * scaleFactor;
    final double labelSpacing = 4.0 * scaleFactor;

    // Calculate font size for input text relative to label font size
    final double inputTextFontSize = labelFontSize * 1.1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label Text (uses scaled labelFontSize)
        Text(
          text,
          style: TextStyle(
            fontSize: labelFontSize,
            color: defaultThemeColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: labelSpacing), // Scaled spacing

        // Text Field Container
        Container(
          width: effectiveWidth, // Use calculated width
          height: textBoxHeight, // Use scaled height from parent
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius), // Scaled radius
          ),
          child: TextSelectionTheme(
            data: TextSelectionTheme.of(context).copyWith(
              selectionColor: effectiveSelectionColor,
              selectionHandleColor: effectiveHandleColor,
              cursorColor: effectiveCursorColor,
            ),
            child: TextFormField(
              controller: nameController,
              focusNode: focusNode,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              cursorColor: effectiveCursorColor,
              cursorWidth: cursorWidth!, // Use base width or scale: cursorWidth! * scaleFactor
              style: TextStyle(fontSize: inputTextFontSize), // Scaled input text
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: text.endsWith('*') ? text.substring(0, text.length - 1) : text,
                hintStyle: TextStyle(
                  fontSize: labelFontSize * 1.05, // Scale hint relative to label
                  color: Colors.grey.shade500,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: internalHPadding, // Scaled horizontal padding
                  // Dynamic vertical padding to center text based on scaled height and font size
                  vertical: (textBoxHeight - (inputTextFontSize * 1.4)) / 2 > 0
                           ? (textBoxHeight - (inputTextFontSize * 1.4)) / 2
                           : 0, // Ensure non-negative padding
                ),
                errorStyle: const TextStyle(height: 0.01, fontSize: 0.01, color: Colors.transparent),
                isDense: true,
              ),
              validator: validator,
              onChanged: onChanged,
              onEditingComplete: () {
                if (focusNode != null && focusNode!.hasFocus) {
                  if (nextFocus != null) {
                    FocusScope.of(context).requestFocus(nextFocus);
                  } else {
                    focusNode!.unfocus();
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
