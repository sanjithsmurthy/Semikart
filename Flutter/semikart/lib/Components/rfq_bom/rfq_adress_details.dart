import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/red_button.dart';
import '../common/popup.dart'; // Import the CustomPopup
// import 'package:flutter_recaptcha_v2_compat/flutter_recaptcha_v2_compat.dart'; // Import reCAPTCHA package (commented)

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

  // --- reCAPTCHA State Variables (commented out) ---
  // final RecaptchaV2Controller _recaptchaV2Controller = RecaptchaV2Controller();
  // bool _captchaVerified = false;
  // final String _recaptchaSiteKey = "6LeEWI8aAAAAADSIswAT2jceMvnEIFgFGVbG1PNc"; // <<<<<<< REPLACE THIS or ada7daukafsd3lqk8292829fa

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
    // Note: RecaptchaV2Controller from flutter_recaptcha_v2_compat typically does not have a dispose() method. (commented)
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

    // --- Check reCAPTCHA status (commented out) ---
    // if (!_captchaVerified) {
    //   if (mounted) {
    //     await CustomPopup.show(
    //       context: context,
    //       title: 'Verification Required',
    //       message: 'Please complete the reCAPTCHA verification.',
    //       buttonText: 'OK',
    //     );
    //   }
    //   return; // Stop submission if reCAPTCHA not verified
    // }
    // --- End reCAPTCHA check ---

    if (_isValid && widget.canSubmit) {
      widget.onSubmit();
    } else if (!_isValid) {
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
    // --- Responsive Scaling Setup (existing) ---
    const double referenceWidth = 412.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / referenceWidth;
    // --- End Responsive Scaling Setup ---

    // --- Scaled Dimensions (existing) ---
    final double titleFontSize = 20.0 * scale;
    final double sectionSpacing = 16.0 * scale;
    final double textBoxSpacing = 10.0 * scale;
    final double rowSpacing = 10.0 * scale;
    final double submitButtonSpacing = 20.0 * scale;
    final double textBoxLabelFontSize = 13.5 * scale;
    final double textBoxHeight = 45.0 * scale;
    final double rowHorizontalSpacing = 16.0 * scale;
    // --- End Scaled Dimensions ---

    const Color primaryColor = Color(0xFFA51414);
    const Color textBoxBackgroundColor = Color(0xFFF5F5F5);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0 * scale, vertical: 10.0 * scale),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: titleFontSize * 0.8,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: sectionSpacing * 0.2),

                  // --- Form Fields (existing GreyTextBox widgets) ---
                  GreyTextBox(
                    nameController: firstNameController,
                    text: 'Full name*',
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize*0.8, 
                    textBoxHeight: textBoxHeight*0.7, 
                    focusNode: firstNameFocus,
                    nextFocus: emailFocus,
                    cursorColor: primaryColor,
                    selectionHandleColor: primaryColor,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Full name is required';
                      }
                      return null;
                    },
                    onChanged: (_) => _validateFields(),
                    scaleFactor: scale, 
                  ),
                  SizedBox(height: textBoxSpacing), 
                  GreyTextBox(
                    nameController: emailController,
                    text: 'Email*',
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize*0.8, 
                    textBoxHeight: textBoxHeight*0.7, 
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
                    scaleFactor: scale, 
                  ),
                  SizedBox(height: textBoxSpacing), 
                  GreyTextBox(
                    nameController: mobileController,
                    text: 'Mobile number*',
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize*0.8, 
                    textBoxHeight: textBoxHeight*0.7, 
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)], 
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
                    scaleFactor: scale, 
                  ),
                  SizedBox(height: textBoxSpacing), 
                  GreyTextBox(
                    nameController: companyController,
                    text: 'Company name',
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize*0.8, 
                    textBoxHeight: textBoxHeight*0.7, 
                    focusNode: companyFocus,
                    nextFocus: gstNoFocus,
                    cursorColor: primaryColor,
                    selectionHandleColor: primaryColor,
                    onChanged: (_) => _validateFields(),
                    scaleFactor: scale, 
                  ),
                  SizedBox(height: textBoxSpacing), 
                  GreyTextBox(
                    nameController: gstNoController,
                    text: 'GST number',
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize*0.8, 
                    textBoxHeight: textBoxHeight*0.7, 
                    focusNode: gstNoFocus,
                    nextFocus: address1Focus,
                    cursorColor: primaryColor,
                    selectionHandleColor: primaryColor,
                    onChanged: (_) => _validateFields(),
                    scaleFactor: scale, 
                  ),
                  SizedBox(height: textBoxSpacing), 
                  GreyTextBox(
                    nameController: address1Controller,
                    text: 'Address line 1*',
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize*0.8, 
                    textBoxHeight: textBoxHeight*0.7, 
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
                    scaleFactor: scale, 
                  ),
                  SizedBox(height: textBoxSpacing), 
                  GreyTextBox(
                    nameController: address2Controller,
                    text: 'Address line 2*',
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize*0.8, 
                    textBoxHeight: textBoxHeight*0.7, 
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
                    scaleFactor: scale, 
                  ),
                  SizedBox(height: textBoxSpacing), 
                  GreyTextBox(
                    nameController: landmarkController,
                    text: 'Landmark*',
                    backgroundColor: textBoxBackgroundColor,
                    labelFontSize: textBoxLabelFontSize*0.8, 
                    textBoxHeight: textBoxHeight*0.7, 
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
                    scaleFactor: scale, 
                  ),
                  SizedBox(height: rowSpacing), 

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GreyTextBox(
                          nameController: zipCodeController,
                          text: 'Zip code*',
                          backgroundColor: textBoxBackgroundColor,
                          labelFontSize: textBoxLabelFontSize*0.8, 
                          textBoxHeight: textBoxHeight*0.7, 
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
                          scaleFactor: scale, 
                        ),
                      ),
                      SizedBox(width: rowHorizontalSpacing), 
                      Expanded(
                        child: GreyTextBox(
                          nameController: stateController,
                          text: 'State*',
                          backgroundColor: textBoxBackgroundColor,
                          labelFontSize: textBoxLabelFontSize*0.8, 
                          textBoxHeight: textBoxHeight*0.7, 
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
                          scaleFactor: scale, 
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: rowSpacing), 

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GreyTextBox(
                          nameController: cityController,
                          text: 'City*',
                          backgroundColor: textBoxBackgroundColor,
                          labelFontSize: textBoxLabelFontSize*0.8, 
                          textBoxHeight: textBoxHeight*0.7, 
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
                          scaleFactor: scale, 
                        ),
                      ),
                      SizedBox(width: rowHorizontalSpacing), 
                      Expanded(
                        child: GreyTextBox(
                          nameController: countryController,
                          text: 'Country*',
                          backgroundColor: textBoxBackgroundColor,
                          labelFontSize: textBoxLabelFontSize*0.8, 
                          textBoxHeight: textBoxHeight*0.7, 
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
                          scaleFactor: scale, 
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sectionSpacing),
                  // --- End Form Fields ---

                  // --- Actual reCAPTCHA Widget (commented out) ---
                  // RecaptchaV2(
                  //   apiKey: _recaptchaSiteKey, // Your Site Key
                  //   apiSecret: "", // Usually empty for v2 checkbox with this package
                  //   controller: _recaptchaV2Controller,
                  //   onVerifiedSuccessfully: (success) {
                  //     if (mounted) {
                  //       setState(() {
                  //         _captchaVerified = success;
                  //       });
                  //       if (success) {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           const SnackBar(content: Text('reCAPTCHA challenge passed.')),
                  //         );
                  //       } else {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           const SnackBar(content: Text('reCAPTCHA challenge not completed.')),
                  //         );
                  //       }
                  //     }
                  //   },
                  //   onVerifiedError: (err) {
                  //     print("reCAPTCHA widget error: $err");
                  //     if (mounted) {
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(content: Text('reCAPTCHA error: $err. Please try again.')),
                  //       );
                  //       setState(() {
                  //         _captchaVerified = false; // Ensure verification is false on error
                  //       });
                  //     }
                  //   },
                  // ),
                  // --- End reCAPTCHA Widget ---

                  SizedBox(height: submitButtonSpacing), // Scaled

                  Center(
                    child: RedButton(
                      label: widget.submitButtonText,
                      onPressed: widget.canSubmit ? _submitForm : () {},
                      width: 110 * scale, // Apply scaling
                      height: 40 * scale, // Apply scaling
                    ),
                  ),
                  SizedBox(height: sectionSpacing), // Scaled bottom padding
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- GreyTextBox Widget (Modified for Scaling - existing) ---
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
  final Color? selectionHandleColor;
  final double scaleFactor;

  const GreyTextBox({
    Key? key,
    required this.nameController,
    required this.text,
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
    this.cursorWidth = 1.5,
    this.selectionColor,
    this.selectionHandleColor,
    required this.scaleFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color defaultThemeColor = Color(0xFFA51414);
    const double referenceWidth = 412.0;

    final Color effectiveHandleColor = selectionHandleColor ?? defaultThemeColor;
    final Color effectiveCursorColor = cursorColor ?? defaultThemeColor;
    final Color effectiveSelectionColor = selectionColor ?? effectiveHandleColor.withOpacity(0.4);

    final double effectiveWidth = width ?? (referenceWidth * 0.9 * scaleFactor);
    final double internalHPadding = 10.0 * scaleFactor;
    final double borderRadius = 8.0 * scaleFactor;
    final double labelSpacing = 4.0 * scaleFactor;
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
        SizedBox(height: labelSpacing),

        // Text Field Container
        Container(
          width: effectiveWidth,
          height: textBoxHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
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
              cursorWidth: cursorWidth!,
              style: TextStyle(fontSize: inputTextFontSize),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: text.endsWith('*') ? text.substring(0, text.length - 1) : text,
                hintStyle: TextStyle(
                  fontSize: labelFontSize * 1.05,
                  color: Colors.grey.shade500,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: internalHPadding,
                  vertical: (textBoxHeight - (inputTextFontSize * 1.4)) / 2 > 0
                           ? (textBoxHeight - (inputTextFontSize * 1.4)) / 2
                           : 0,
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
