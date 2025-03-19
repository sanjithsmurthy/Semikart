import 'package:flutter/material.dart';

class CustomDropdownField extends StatefulWidget {
  final String? value;
  final String label;
  final Function(String?) onChanged;
  final EdgeInsetsGeometry? padding;

  CustomDropdownField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.padding,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  final List<String> _indianStates = [
    'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
    'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka',
    'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram',
    'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu',
    'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal',
    'Andaman and Nicobar Islands', 'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu', 'Delhi', 'Jammu and Kashmir',
    'Ladakh', 'Lakshadweep', 'Puducherry',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 367,
      height: 72,
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: DropdownButtonFormField<String>(
          value: widget.value,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(
              color: Color(0xFFA51414),
              backgroundColor: Colors.white,
              fontSize: 16,
              height: 19/16,
              fontFamily: 'Product Sans',
            ),
            floatingLabelStyle: TextStyle(
              color: Color(0xFFA51414),
              backgroundColor: Colors.white,
              fontSize: 16,
              fontFamily: 'Product Sans',
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.only(left: 29.0, top: 20, bottom: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Color(0xFFA51414),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Color(0xFFA51414),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Color(0xFFA51414),
                width: 1.0,
              ),
            ),
          ),
          style: TextStyle(
            color: Color(0xFF757575),
            fontSize: 18,
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.normal,
          ),
          items: _indianStates.map((String state) {
            return DropdownMenuItem<String>(
              value: state,
              child: Text(state),
            );
          }).toList(),
          onChanged: widget.onChanged,
          icon: Icon(Icons.arrow_drop_down, color: Color(0xFF757575)),
          isExpanded: true,
          dropdownColor: Colors.white,
          focusColor: Colors.transparent,
          elevation: 2,
        ),
      ),
    );
  }
}