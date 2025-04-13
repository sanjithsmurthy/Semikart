import 'package:flutter/material.dart';

class GreyTextBox extends StatelessWidget {
  final TextEditingController nameController;
  final String text; // Single parameter for both label and hint text
  final double? width; // Optional width parameter
  final Color backgroundColor; // Background color parameter
  final FocusNode? focusNode; // Optional FocusNode parameter
  final VoidCallback? onTap; // Optional onTap callback

  GreyTextBox({
    Key? key,
    required this.nameController,
    this.text = 'Name', // Default value for label and hint text
    this.width, // Optional width
    this.backgroundColor =
        const Color(0xFFE4E8EC), // Default grey background color
    this.focusNode, // Optional FocusNode
    this.onTap, // Optional onTap callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text, // Use the single parameter for label text
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFFA51414), // Adjust the color as needed
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: width ??
              screenWidth *
                  0.9, // Default to 90% of screen width if width is not provided
          height: 41.54,
          decoration: BoxDecoration(
            color: backgroundColor, // Use the customizable background color
            borderRadius: BorderRadius.circular(9),
          ),
          child: TextField(
            cursorColor: Colors.black, // Set the cursor color to black
            controller: nameController,
            focusNode: focusNode, // Attach the FocusNode
            onTap: onTap, // Attach the onTap callback
            decoration: InputDecoration(
              hintText: text, // Use the same parameter for hint text
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }
}
