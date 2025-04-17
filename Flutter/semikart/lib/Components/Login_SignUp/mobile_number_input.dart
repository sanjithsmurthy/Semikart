import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for input formatters

class MobileNumberField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final List<String> countryCodes; // List of country codes
  final String defaultCountryCode; // Default country code
  final Function(String)? onCountryCodeChanged; // Callback for country code change
  final Function(String)? onValidationFailed; // Callback for validation failure
  final EdgeInsetsGeometry? padding; // Optional padding parameter
  final double? width; // Optional width parameter
  final double? height; // Optional height parameter

  const MobileNumberField({
    super.key,
    required this.controller,
    required this.label,
    this.countryCodes = _defaultCountryCodes, // Default to all country codes
    this.defaultCountryCode = '+91', // Default to India
    this.onCountryCodeChanged,
    this.onValidationFailed,
    this.padding,
    this.width, // Optional width parameter
    this.height, // Optional height parameter - THIS CONTROLS THE OVERALL HEIGHT
  });

  // Default country codes list remains the same
  static const List<String> _defaultCountryCodes = [
    '+1', '+44', '+91', '+61', '+81', '+49', '+33', '+39', '+86', '+7', '+55', '+27', '+34', '+82', '+31', '+47',
    '+46', '+41', '+64', '+52', '+60', '+65', '+62', '+63', '+66', '+92', '+20', '+212', '+213', '+216',
    '+971', '+972', '+90', '+98', '+880', '+94', '+84', '+351', '+48', '+32', '+30', '+45', '+353', '+420', '+36',
    '+40', '+380', '+375', '+372', '+371', '+370', '+43', '+358', '+386', '+385', '+381', '+382', '+389', '+373',
    '+994', '+995', '+374', '+976', '+977', '+93', '+964', '+968', '+974', '+973', '+965', '+966', '+962', '+961',
    '+963', '+967', '+211', '+254', '+256', '+255', '+250', '+263', '+260', '+267', '+258', '+231', '+232', '+233',
    '+234', '+235', '+236', '+237', '+238', '+239', '+240', '+241', '+242', '+243', '+244', '+245', '+246', '+247',
    '+248', '+249', '+250', '+251', '+252', '+253', '+254', '+255', '+256', '+257', '+258', '+260', '+261', '+262',
    '+263', '+264', '+265', '+266', '+267', '+268', '+269', '+290', '+291', '+297', '+298', '+299',
  ];

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  late String _selectedCountryCode;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _selectedCountryCode = widget.defaultCountryCode; // Initialize with default country code
  }

  void _validateMobileNumber(String number) {
    // Example validation logic based on country code
    // Basic check for 10 digits, adjust as needed for different country codes
    final isValid = RegExp(r'^\d{10}$').hasMatch(number);
    if (!isValid && number.isNotEmpty) { // Show error only if not empty and invalid
      setState(() {
        _errorMessage = 'Invalid mobile number';
      });
      if (widget.onValidationFailed != null) {
        widget.onValidationFailed!(number);
      }
    } else {
      setState(() {
        _errorMessage = null; // Clear error message if valid or empty
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the width dynamically based on screen size - SAME AS PasswordTextField
    final screenWidth = MediaQuery.of(context).size.width;
    // Use provided width or default to 90% of screen width
    final calculatedWidth = widget.width ?? (screenWidth * 0.9);

    // Define the border style - same for all states to prevent visual changes
    // Use BorderRadius.circular(20) to match PasswordTextField
    var borderStyle = OutlineInputBorder( // Make const
      borderRadius: BorderRadius.circular(20), // Match PasswordTextField
      borderSide: BorderSide(
        color: Color(0xFFA51414), // Keep the red border color consistent
        width: 2.0, // Consistent border width
      ),
    );

    // Define the error border style (optional, but good practice)
    var errorBorderStyle = OutlineInputBorder( // Make const
      borderRadius: BorderRadius.circular(20), // Match PasswordTextField
      borderSide: BorderSide(
        color: Colors.red, // Standard error color
        width: 2.0,
      ),
    );


    return Padding(
      // Default padding to 0 to match PasswordTextField
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        width: calculatedWidth, // Use the calculated width (defaults to 90% screen width)
        // Use the height passed from the constructor. If null, intrinsic height is used.
        height: widget.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Take minimum vertical space
          children: [
            // --- Wrap Row with IntrinsicHeight ---
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children vertically
                children: [
                  // Country Code Dropdown
                  Flexible(
                    flex: 3, // Adjust flex ratio as needed (e.g., 30% width)
                    child: DropdownButtonFormField<String>(
                      value: _selectedCountryCode,
                      decoration: InputDecoration(
                        // labelText: "Code", // Removed label to save space if needed
                        labelStyle: const TextStyle( // Make const
                          color: Color(0xFF757575),
                          fontSize: 16,
                        ),
                        floatingLabelStyle: const TextStyle( // Make const
                          color: Color(0xFFA51414),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        // Apply consistent border style
                        border: borderStyle,
                        enabledBorder: borderStyle,
                        focusedBorder: borderStyle,
                        errorBorder: errorBorderStyle, // Use error style if needed
                        focusedErrorBorder: errorBorderStyle, // Use error style if needed
                        filled: true,
                        fillColor: Colors.white,
                        // Adjust content padding for vertical alignment if needed
                        // Matched vertical padding with PasswordTextField
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0), // Make const
                        // --- Add isDense for potentially better alignment ---
                        isDense: true,
                      ),
                      items: MobileNumberField._defaultCountryCodes.map((String code) {
                        return DropdownMenuItem<String>(
                          value: code,
                          child: Text(
                            code,
                            style: const TextStyle( // Make const
                              color: Color(0xFF757575),
                              fontSize: 16, // Matched font size
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCountryCode = value;
                          });
                          if (widget.onCountryCodeChanged != null) {
                            widget.onCountryCodeChanged!(value);
                          }
                          // Re-validate number when country code changes (optional)
                          _validateMobileNumber(widget.controller.text);
                        }
                      },
                      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF757575)), // Make const
                      isExpanded: true,
                      dropdownColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8), // Spacing between dropdown and text field

                  // Mobile Number Input Field
                  Flexible(
                    flex: 7, // Adjust flex ratio as needed (e.g., 70% width)
                    child: TextFormField( // Use TextFormField for potential validation integration
                      controller: widget.controller,
                      keyboardType: TextInputType.number, // Set keyboard type to number
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Allow only numeric input
                      cursorColor: Colors.black, // Set the cursor color to black
                      cursorHeight: 20.0, // Match PasswordTextField cursor height
                      textAlignVertical: TextAlignVertical.center, // Vertically center the text
                      decoration: InputDecoration(
                        labelText: widget.label,
                        labelStyle: const TextStyle( // Make const
                          color: Color(0xFF757575),
                          fontSize: 16, // Matched font size
                          height: 1.2, // Match PasswordTextField
                        ),
                        floatingLabelStyle: const TextStyle( // Make const
                          color: Color(0xFFA51414),
                          fontSize: 16, // Matched font size
                          // fontWeight: FontWeight.bold, // Optional: match PasswordTextField
                        ),
                        // Apply consistent border style
                        border: borderStyle,
                        enabledBorder: borderStyle,
                        focusedBorder: borderStyle,
                        errorBorder: errorBorderStyle, // Use error style if needed
                        focusedErrorBorder: errorBorderStyle, // Use error style if needed
                        // Match content padding
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0), // Make const
                        // Hide default error text space if using custom error display
                        errorStyle: const TextStyle(height: 0, fontSize: 0), // Make const
                        // --- Add isDense for potentially better alignment ---
                        isDense: true,
                      ),
                      onChanged: (value) {
                        _validateMobileNumber(value);
                      },
                      // Optional: Add validator for Form integration
                      validator: (value) {
                         if (value == null || value.isEmpty) return null; // Allow empty
                         final isValid = RegExp(r'^\d{10}$').hasMatch(value); // Example validation
                         return isValid ? null : 'Invalid number'; // Return error string or null
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction, // Validate on interaction
                      style: const TextStyle( // Added style to match PasswordTextField
                        fontSize: 16,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Custom Error Message Display (below the fields)
            if (_errorMessage != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  // Optional: Add padding to align with text field content
                  // SizedBox(width: calculatedWidth * 0.3 + 8), // Align with number field start
                  const Icon( // Make const
                    Icons.error_outline, // Use a standard error icon
                    color: Color(0xFFA51414),
                    size: 18, // Adjust size
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle( // Make const
                        color: Color(0xFFA51414),
                        fontSize: 12, // Smaller font for error
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}