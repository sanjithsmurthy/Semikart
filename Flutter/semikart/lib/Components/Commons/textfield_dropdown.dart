import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // Add this import

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
  late TextEditingController _textController;
  final FocusNode _focusNode = FocusNode();
  int _selectedIndex = -1;

  final List<String> _indianStates = [
    'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
    'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka',
    'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram',
    'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu',
    'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal',
    // Union Territories
    'Andaman and Nicobar Islands', 'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu', 'Delhi', 'Jammu and Kashmir',
    'Ladakh', 'Lakshadweep', 'Puducherry',
  ];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _textController.text = widget.value ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 367,
      height: 72,
      child: RawAutocomplete<String>(
        textEditingController: _textController,
        focusNode: _focusNode,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return _indianStates;
          }
          return _indianStates.where((String option) {
            return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
        },
        fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            style: TextStyle(
              color: Color(0xFF757575),
              fontSize: 18,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.normal,
            ),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
            onChanged: (String value) {
              setState(() {
                // Always update the text value
                _textController.text = value;
                widget.onChanged(value);

                if (value.isEmpty) {
                  // Reset selection when text is empty
                  _selectedIndex = -1;
                  return;
                }

                // Check for matches in the list
                final matches = _indianStates.where((option) => 
                  option.toLowerCase().contains(value.toLowerCase())
                ).toList();

                // Update selected index if we have matches
                if (matches.isNotEmpty) {
                  _selectedIndex = _indianStates.indexOf(matches[0]);
                } else {
                  _selectedIndex = -1;
                }
              });
            },
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
              suffixIcon: Icon(Icons.arrow_drop_down, color: Color(0xFF757575)),
            ),
          );
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: Container(
                width: 367,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    final bool isSelected = index == _selectedIndex;

                    return ListTile(
                      title: Text(
                        option,
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      tileColor: isSelected ? Color(0xFFEEEEEE) : Colors.transparent,
                      onTap: () {
                        onSelected(option);
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
        onSelected: (String selection) {
          setState(() {
            _selectedIndex = _indianStates.indexOf(selection);
            _textController.text = selection;
            widget.onChanged(selection);
          });
          _focusNode.unfocus();
        },
      ),
    );
  }
}