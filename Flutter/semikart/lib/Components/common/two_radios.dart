import 'package:flutter/material.dart';

class TwoRadioButtons extends StatefulWidget {
  final List<String> options; // List of options for the radio buttons
  final Function(int) onSelectionChanged; // Callback for selection change
  final int initialSelection; // Initial selected index
  final double radioWidth; // Width of the radio button
  final double radioHeight; // Height of the radio button

  const TwoRadioButtons({
    Key? key,
    required this.options,
    required this.onSelectionChanged,
    this.initialSelection = 0,
    this.radioWidth = 20.0, // Default width
    this.radioHeight = 24.0, // Default height
  }) : super(key: key);

  @override
  State<TwoRadioButtons> createState() => _TwoRadioButtonsState();
}

class _TwoRadioButtonsState extends State<TwoRadioButtons> {
  late int _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialSelection; // Initialize with the provided selection
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine layout based on screen width
    final isVerticalLayout = screenWidth < 400; // Use vertical layout for small screens

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding for responsiveness
      child: isVerticalLayout
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.options.asMap().entries.map((entry) {
                final index = entry.key;
                final label = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0), // Add spacing between items
                  child: Row(
                    children: [
                      SizedBox(
                        width: widget.radioWidth, // Use the passed width
                        height: widget.radioHeight, // Use the passed height
                        child: Radio(
                          value: index,
                          groupValue: _selectedValue,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedValue = value!;
                              widget.onSelectionChanged(_selectedValue); // Notify parent widget
                            });
                          },
                          activeColor: const Color(0xFFA51414), // Custom active color
                        ),
                      ),
                      const SizedBox(width: 8), // Spacing between radio and label
                      Expanded(
                        child: Text(
                          label,
                          style: const TextStyle(

                            fontSize: 17,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Allow horizontal scrolling
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: widget.options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final label = entry.value;

                  return Row(
                    children: [
                      SizedBox(
                        width: widget.radioWidth, // Use the passed width
                        height: widget.radioHeight, // Use the passed height
                        child: Radio(
                          value: index,
                          groupValue: _selectedValue,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedValue = value!;
                              widget.onSelectionChanged(_selectedValue); // Notify parent widget
                            });
                          },
                          activeColor: const Color(0xFFA51414), // Custom active color
                        ),
                      ),
                      const SizedBox(width: 8), // Spacing between radio and label
                      Text(
                        label,
                        style: const TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 17,
                          color: Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(width: 24), // Spacing between radio button groups
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}