import 'package:flutter/material.dart';

class TwoRadioButtons extends StatefulWidget {
  final String firstLabel;
  final String secondLabel;
  final Function(int) onSelectionChanged;
  final int initialSelection;
  final double? radioWidth;    // Add these new parameters
  final double? radioHeight;

  const TwoRadioButtons({
    Key? key,
    required this.firstLabel,
    required this.secondLabel,
    required this.onSelectionChanged,
    this.initialSelection = 0,
    this.radioWidth = 20,     // Default width
    this.radioHeight = 24,    // Default height
  }) : super(key: key);

  @override
  State<TwoRadioButtons> createState() => _TwoRadioButtonsState();
}

class _TwoRadioButtonsState extends State<TwoRadioButtons> {
  late int _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            SizedBox(
              width: widget.radioWidth,    // Use the passed width
              height: widget.radioHeight,  // Use the passed height
              child: Radio(
                value: 0,
                groupValue: _selectedValue,
                onChanged: (int? value) {
                  setState(() {
                    _selectedValue = value!;
                    widget.onSelectionChanged(_selectedValue);
                  });
                },
                activeColor: Color(0xFFA51414),
              ),
            ),
            SizedBox(width: 8),
            Text(
              widget.firstLabel,
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 17,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
        SizedBox(width: 24),
        Row(
          children: [
            SizedBox(
              width: widget.radioWidth,    // Use the passed width
              height: widget.radioHeight,  // Use the passed height
              child: Radio(
                value: 1,
                groupValue: _selectedValue,
                onChanged: (int? value) {
                  setState(() {
                    _selectedValue = value!;
                    widget.onSelectionChanged(_selectedValue);
                  });
                },
                activeColor: Color(0xFFA51414),
              ),
            ),
            SizedBox(width: 8),
            Text(
              widget.secondLabel,
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 17,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      ],
    );
  }
}