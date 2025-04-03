import 'package:flutter/material.dart';

class MobileNumberField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final List<String> countryCodes; // List of country codes
  final String defaultCountryCode; // Default country code
  final Function(String)? onCountryCodeChanged; // Callback for country code change
  final Function(String)? onValidationFailed; // Callback for validation failure
  final EdgeInsetsGeometry? padding; // Optional padding parameter
  final double width; // Width of the text field

  const MobileNumberField({
    super.key,
    required this.controller,
    required this.label,
    this.countryCodes = _defaultCountryCodes, // Default to all country codes
    this.defaultCountryCode = '+91', // Default to India
    this.onCountryCodeChanged,
    this.onValidationFailed,
    this.padding,
    this.width = 370.0, // Default width
  });

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
    final isValid = RegExp(r'^\d{10}$').hasMatch(number); // Validate for 10 digits
    if (!isValid) {
      setState(() {
        _errorMessage = 'Invalid mobile number';
      });
      if (widget.onValidationFailed != null) {
        widget.onValidationFailed!(number);
      }
    } else {
      setState(() {
        _errorMessage = null; // Clear error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive widths
        final totalWidth = constraints.maxWidth;

        return Padding(
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: totalWidth, // Use the total available width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Country Code Dropdown
                    Flexible(
                      flex: 3, // Adjust flex ratio as needed
                      child: DropdownButtonFormField<String>(
                        value: _selectedCountryCode,
                        decoration: InputDecoration(
                          labelText: "Code",
                          labelStyle: TextStyle(
                            color: Color(0xFF757575),
                            fontSize: 16,
                            fontFamily: 'Product Sans',
                          ),
                          floatingLabelStyle: TextStyle(
                            color: Color(0xFFA51414),
                            fontSize: 16,
                            fontFamily: 'Product Sans',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFFA51414), width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFFA51414), width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFFA51414), width: 1.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: MobileNumberField._defaultCountryCodes.map((String code) {
                          return DropdownMenuItem<String>(
                            value: code,
                            child: Text(
                              code,
                              style: TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 16,
                                fontFamily: 'Product Sans',
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCountryCode = value!;
                          });
                          if (widget.onCountryCodeChanged != null) {
                            widget.onCountryCodeChanged!(value!);
                          }
                        },
                        icon: Icon(Icons.arrow_drop_down, color: Color(0xFF757575)),
                        isExpanded: true,
                        dropdownColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8), // Spacing between dropdown and text field

                    // Mobile Number Input Field
                    Flexible(
                      flex: 7, // Adjust flex ratio as needed
                      child: TextField(
                        controller: widget.controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: widget.label,
                          labelStyle: TextStyle(
                            color: Color(0xFF757575),
                            fontSize: 16,
                            fontFamily: 'Product Sans',
                          ),
                          floatingLabelStyle: TextStyle(
                            color: Color(0xFFA51414),
                            fontSize: 16,
                            fontFamily: 'Product Sans',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xFFA51414), width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xFFA51414), width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xFFA51414), width: 1.0),
                          ),
                        ),
                        onChanged: (value) {
                          _validateMobileNumber(value);
                        },
                      ),
                    ),
                  ],
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFA51414),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.priority_high,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: Color(0xFFA51414),
                            fontSize: 14,
                            fontFamily: 'Product Sans',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}