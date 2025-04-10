import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for input formatters
import 'package:intl_phone_field/intl_phone_field.dart';
import 'mobile_number_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Mobile Number Input")),
        body: Center(
          child: MobileNumberField(
            controller: TextEditingController(),
            label: "Mobile Number",
            onCountryCodeChanged: (code) {
              print("Selected Country Code: $code");
            },
            onValidationFailed: (number) {
              print("Invalid Number: $number");
            },
          ),
        ),
      ),
    );
  }
}

class MobileNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String)? onCountryCodeChanged;
  final Function(String)? onValidationFailed;
  final EdgeInsetsGeometry? padding;
  final double width;

  const MobileNumberField({
    super.key,
    required this.controller,
    required this.label,
    this.onCountryCodeChanged,
    this.onValidationFailed,
    this.padding,
    this.width = 370.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: width,
        child: IntlPhoneField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
          initialCountryCode: 'IN', // Default country code (India)
          onChanged: (phone) {
            if (onCountryCodeChanged != null) {
              onCountryCodeChanged!(phone.countryCode);
            }
          },
          onCountryChanged: (country) {
            if (onCountryCodeChanged != null) {
              onCountryCodeChanged!(country.dialCode);
            }
          },
          validator: (value) {
            if (value == null ||
                value.number.isEmpty ||
                value.number.length < 10) {
              if (onValidationFailed != null) {
                onValidationFailed!(value?.number ?? '');
              }
              return 'Invalid mobile number';
            }
            return null;
          },
        ),
      ),
    );
  }
}
