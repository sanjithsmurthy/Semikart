import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/red_button.dart';
// Removed duplicate GreyTextBox import as it's defined below
// import '../common/grey_text_box.dart';
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

    // Check if mounted before calling setState to avoid errors after dispose
    if (mounted) {
      setState(() {
        _errorMessage = errorMessage;
        _isValid = isValid;
      });
    }

    widget.onValidationChanged(isValid);
  }

  void _submitForm() async {
    // Re-validate before attempting submission
    _validateFields();

    if (_isValid) {
      widget.onSubmit();
    } else {
      // Use CustomPopup for error message
      // Check if mounted before showing the popup
      if (!mounted) return;
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

    // --- Sizing based on original context ---
    final double titleFontSize = screenWidth * 0.05;
    final double sectionSpacing = screenWidth * 0.04;
    final double textBoxSpacing = screenWidth * 0.025;
    final double rowSpacing = screenWidth * 0.025;
    // final double textBoxWidth = screenWidth * 0.9; // Not used directly, GreyTextBox handles width
    final double reCaptchaHeight = screenHeight * 0.06;
    final double reCaptchaFontSize = screenWidth * 0.035;
    final double submitButtonSpacing = screenWidth * 0.05;
    final double textBoxLabelFontSize = screenWidth * 0.0325;
    final double textBoxHeight = screenHeight * 0.05;
    final double rowHorizontalSpacing = screenWidth * 0.075;

    // Define the primary color for reuse
    const Color primaryColor = Color(0xFFA51414);
    const Color textBoxBackgroundColor = Color(0xFFE4E8EC);

    return Container(
      color: Colors.white,
      // Use SafeArea to avoid overlaps with system UI
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            // Use symmetric padding for consistency
            padding: EdgeInsets.symmetric(horizontal: sectionSpacing, vertical: sectionSpacing),
            child: Form(
              key: _formKey,
              // Consider adding autovalidateMode for instant feedback
              // autovalidateMode: AutovalidateMode.onUserInteraction,
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

                  // --- Form Fields ---
                  // Pass the primary color for cursor and selection handles
                  GreyTextBox(
                    nameController: firstNameController,
                    text: 'First name*',
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize,
                    textBoxHeight: textBoxHeight,
                    focusNode: firstNameFocus,
                    nextFocus: emailFocus,
                    cursorColor: primaryColor,
                    selectionHandleColor: primaryColor, // Pass handle color
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
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
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize,
                    textBoxHeight: textBoxHeight,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFocus,
                    nextFocus: mobileFocus,
                    cursorColor: primaryColor,
                    selectionHandleColor: primaryColor,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      // Improved email validation regex
                      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
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
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize,
                    textBoxHeight: textBoxHeight,
                    keyboardType: TextInputType.phone, // Use phone type
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      // Regex check is redundant due to inputFormatter
                      return null;
                    },
                    onChanged: (_) => _validateFields(),
                  ),
                  SizedBox(height: textBoxSpacing),
                  GreyTextBox(
                    nameController: companyController,
                    text: 'Company name', // Optional
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize,
                    textBoxHeight: textBoxHeight,
                    focusNode: companyFocus,
                    nextFocus: gstNoFocus,
                    cursorColor: primaryColor,
                    selectionHandleColor: primaryColor,
                    onChanged: (_) => _validateFields(), // Still validate optional fields
                  ),
                  SizedBox(height: textBoxSpacing),
                  GreyTextBox(
                    nameController: gstNoController,
                    text: 'GST number', // Optional
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize,
                    textBoxHeight: textBoxHeight,
                    // Consider TextInputType.text and formatters for GST
                    // keyboardType: TextInputType.text,
                    // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))],
                    focusNode: gstNoFocus,
                    nextFocus: address1Focus,
                    cursorColor: primaryColor,
                    selectionHandleColor: primaryColor,
                    onChanged: (_) => _validateFields(),
                  ),
                  SizedBox(height: textBoxSpacing),
                  GreyTextBox(
                    nameController: address1Controller,
                    text: 'Address line 1*',
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize,
                    textBoxHeight: textBoxHeight,
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
                  ),
                  SizedBox(height: textBoxSpacing),
                  GreyTextBox(
                    nameController: address2Controller,
                    text: 'Address line 2*',
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize,
                    textBoxHeight: textBoxHeight,
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
                  ),
                  SizedBox(height: textBoxSpacing),
                  GreyTextBox(
                    nameController: landmarkController,
                    text: 'Landmark*',
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize,
                    textBoxHeight: textBoxHeight,
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
                  ),
                  SizedBox(height: rowSpacing), // Use rowSpacing before Row

                  // --- Row for Zip Code and State ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align tops
                    children: [
                      Expanded(
                        // flex: 1, // Default flex is 1
                        child: GreyTextBox(
                          nameController: zipCodeController,
                          text: 'Zip code*',
                          backgroundColor: textBoxBackgroundColor,
                          labelFontSize: textBoxLabelFontSize,
                          textBoxHeight: textBoxHeight,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6), // Limit length
                          ],
                          focusNode: zipCodeFocus,
                          nextFocus: stateFocus,
                          cursorColor: primaryColor,
                          selectionHandleColor: primaryColor,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Zip code is required';
                            }
                            // Regex check redundant due to formatter
                            if (value.trim().length < 6) {
                              return 'Please enter a valid zip code';
                            }
                            return null;
                          },
                          onChanged: (_) => _validateFields(),
                        ),
                      ),
                      SizedBox(width: rowHorizontalSpacing),
                      Expanded(
                        // flex: 1,
                        child: GreyTextBox(
                          nameController: stateController,
                          text: 'State*',
                          backgroundColor: textBoxBackgroundColor,
                          labelFontSize: textBoxLabelFontSize,
                          textBoxHeight: textBoxHeight,
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: rowSpacing),

                  // --- Row for City and Country ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        // flex: 1,
                        child: GreyTextBox(
                          nameController: cityController,
                          text: 'City*',
                          backgroundColor: textBoxBackgroundColor,
                          labelFontSize: textBoxLabelFontSize,
                          textBoxHeight: textBoxHeight,
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
                        ),
                      ),
                      SizedBox(width: rowHorizontalSpacing),
                      Expanded(
                        // flex: 1,
                        child: GreyTextBox(
                          nameController: countryController,
                          text: 'Country*',
                          backgroundColor: textBoxBackgroundColor,
                          labelFontSize: textBoxLabelFontSize,
                          textBoxHeight: textBoxHeight,
                          focusNode: countryFocus,
                          // No next focus, unfocus on complete
                          cursorColor: primaryColor,
                          selectionHandleColor: primaryColor,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
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

                  // --- Placeholder for reCAPTCHA ---
                  // Consider implementing a real reCAPTCHA solution if needed
                  Container(
                    height: reCaptchaHeight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400), // Lighter border
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "I'm not a robot (Placeholder)", // Indicate it's a placeholder
                        style: TextStyle(
                          fontSize: reCaptchaFontSize,
                          color: Colors.grey.shade600, // Slightly darker grey
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: submitButtonSpacing),

                  // --- Submit Button ---
                  Center(
                    child: RedButton(
                      label: widget.submitButtonText,
                      // Disable button visually if not valid or cannot submit
                      // Use _isValid state which is updated by _validateFields
                      onPressed: widget.canSubmit ? _submitForm : () {},
                      // Optionally change button style when disabled
                      // backgroundColor: _isValid && widget.canSubmit ? primaryColor : Colors.grey,
                    ),
                  ),
                  SizedBox(height: sectionSpacing), // Add some padding at the bottom
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// --- GreyTextBox Widget (Modified for Selection Handle Color) ---
class GreyTextBox extends StatelessWidget {
  final TextEditingController nameController;
  final String text; // Acts as both label and hint
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
  final Color? selectionColor; // Background color of selected text
  final Color? selectionHandleColor; // Color of the selection handles (bubbles)

  const GreyTextBox({
    Key? key,
    required this.nameController,
    required this.text, // Make text required
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
    this.cursorColor, // Default set below
    this.cursorWidth = 1.5, // Slightly thicker cursor
    this.selectionColor, // Default set below
    this.selectionHandleColor, // Default set below
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Define the default theme color
    const Color defaultThemeColor = Color(0xFFA51414);

    // Determine effective colors
    final Color effectiveHandleColor = selectionHandleColor ?? defaultThemeColor;
    final Color effectiveCursorColor = cursorColor ?? defaultThemeColor;
    final Color effectiveSelectionColor = selectionColor ?? effectiveHandleColor.withOpacity(0.4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Take minimum vertical space
      children: [
        // Label Text
        Text(
          text,
          style: TextStyle(
            fontSize: labelFontSize,
            color: defaultThemeColor, // Use the theme color for label
            fontWeight: FontWeight.w500, // Slightly bolder label
          ),
        ),
        const SizedBox(height: 4), // Consistent small spacing

        // Text Field Container
        Container(
          width: width ?? screenWidth * 0.9, // Use provided width or default
          height: textBoxHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8), // Slightly smaller radius
          ),
          // Apply TextSelectionTheme for handle color
          child: TextSelectionTheme(
            data: TextSelectionTheme.of(context).copyWith(
              selectionColor: effectiveSelectionColor,
              selectionHandleColor: effectiveHandleColor, // *** Set the handle color ***
              cursorColor: effectiveCursorColor, // Ensure cursor color matches theme
            ),
            child: TextFormField(
              controller: nameController,
              focusNode: focusNode,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              cursorColor: effectiveCursorColor, // Use themed cursor color
              cursorWidth: cursorWidth!,
              style: TextStyle(fontSize: labelFontSize * 1.1), // Slightly larger input text
              textAlignVertical: TextAlignVertical.center, // Center text vertically
              decoration: InputDecoration(
                // Use label text also as hint text (remove asterisk)
                hintText: text.endsWith('*') ? text.substring(0, text.length - 1) : text,
                hintStyle: TextStyle(
                  fontSize: labelFontSize * 1.05,
                  color: Colors.grey.shade500,
                ),
                // Remove default border and use container's border/background
                border: InputBorder.none,
                // Adjust content padding for vertical centering
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  // Calculate vertical padding dynamically
                  vertical: (textBoxHeight - (labelFontSize * 1.1 * 1.4)) / 2,
                ),
                // Hide default error text space
                errorStyle: const TextStyle(height: 0.01, fontSize: 0.01, color: Colors.transparent),
                isDense: true, // Reduces intrinsic padding
              ),
              validator: validator,
              onChanged: onChanged,
              // Handle focus transition on editing complete
              onEditingComplete: () {
                if (focusNode != null && focusNode!.hasFocus) {
                  if (nextFocus != null) {
                    FocusScope.of(context).requestFocus(nextFocus);
                  } else {
                    focusNode!.unfocus(); // Unfocus if it's the last field
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
