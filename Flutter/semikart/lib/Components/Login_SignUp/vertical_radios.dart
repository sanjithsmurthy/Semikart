import 'package:flutter/material.dart';

class VerticalRadios extends StatefulWidget {
  final Function(String) onOptionSelected; // Callback for selected option

  VerticalRadios({required this.onOptionSelected}); // Constructor to accept the callback

  @override
  _VerticalRadiosState createState() => _VerticalRadiosState();
}

class _VerticalRadiosState extends State<VerticalRadios> {
  String _selectedOption = "password"; // Default selected option

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamically calculate dimensions
    final containerWidth = screenWidth * 0.9; // Adjusted width for both radios
    final containerHeight = screenHeight * 0.2; // Adjusted height for both radios
    final radioSize = (containerHeight * 0.2); // Adjusted size for radio buttons
    final textFontSize = containerHeight * 0.1; // Adjusted font size

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(containerWidth * 0.08), // 8% of container width
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Add horizontal padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space out the radios evenly
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Radio (Login with Password)
            Row(
              children: [
                SizedBox(
                  width: radioSize,
                  height: radioSize,
                  child: Radio<String>(
                    value: "password", // Value for the first radio
                    groupValue: _selectedOption, // Current selected option
                    activeColor: Color(0xFFA51414), // Red color for selected radio
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!; // Update the selected radio option
                        widget.onOptionSelected(_selectedOption); // Pass value to parent
                      });
                    },
                  ),
                ),
                SizedBox(width: 10), // Spacing between radio and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login with",
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: textFontSize,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: textFontSize,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Second Radio (Login with OTP)
            Row(
              children: [
                SizedBox(
                  width: radioSize,
                  height: radioSize,
                  child: Radio<String>(
                    value: "otp", // Value for the second radio
                    groupValue: _selectedOption, // Current selected option
                    activeColor: Color(0xFFA51414), // Red color for selected radio
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!; // Update the selected radio option
                        widget.onOptionSelected(_selectedOption); // Pass value to parent
                      });
                    },
                  ),
                ),
                SizedBox(width: 10), // Spacing between radio and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login with",
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: textFontSize,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Text(
                        "OTP",
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: textFontSize,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}