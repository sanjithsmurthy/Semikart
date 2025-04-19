import 'package:flutter/material.dart';

class TwoRadioButtons extends StatefulWidget {
  final List<String> options; // List of options for the radio buttons
  final Function(int) onSelectionChanged; // Callback for selection change
  final int initialSelection; // Initial selected index
  final double radioWidth; // Width of the radio button
  final double radioHeight; // Height of the radio button
  final bool forceHorizontalLayout; // New parameter to force Row layout

  const TwoRadioButtons({
    Key? key,
    required this.options,
    required this.onSelectionChanged,
    this.initialSelection = 0,
    this.radioWidth = 20.0, // Default width
    this.radioHeight = 24.0, // Default height
    this.forceHorizontalLayout = false, // Default to false (existing behavior)
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

    // Determine layout: Use horizontal if forced OR if screen is wide enough
    final bool useHorizontalLayout = widget.forceHorizontalLayout || screenWidth >= 400;

    // Build the list of radio button widgets
    List<Widget> radioItems = widget.options.asMap().entries.map((entry) {
      final index = entry.key;
      final label = entry.value;

      return Row(
        mainAxisSize: MainAxisSize.min, // Important for horizontal layout
        children: [
          SizedBox(
            width: widget.radioWidth, // Use the passed width
            height: widget.radioHeight, // Use the passed height
            child: Radio(
              value: index,
              groupValue: _selectedValue,
              onChanged: (int? value) {
                if (value != null && mounted) { // Add mounted check
                  setState(() {
                    _selectedValue = value;
                    widget.onSelectionChanged(_selectedValue); // Notify parent widget
                  });
                }
              },
              activeColor: const Color(0xFFA51414), // Custom active color
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area
              visualDensity: VisualDensity.compact, // Make it more compact
            ),
          ),
          const SizedBox(width: 4), // Reduced spacing between radio and label
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.035, // Dynamic font size
              color: const Color(0xFF000000),
            ),
          ),
          // Add spacing only if NOT the last item in horizontal layout
          if (useHorizontalLayout && index < widget.options.length - 1)
            const SizedBox(width: 16), // Spacing between radio button groups
        ],
      );
    }).toList();

    // Return the appropriate layout widget
    return useHorizontalLayout
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end, // Align to the end (right)
            mainAxisSize: MainAxisSize.min, // Take minimum space needed
            children: radioItems,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Take minimum space needed
            children: radioItems,
          );
  }
}