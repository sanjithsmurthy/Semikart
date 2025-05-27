import 'package:flutter/material.dart';

class GreyTextBox extends StatelessWidget {
  final TextEditingController nameController;
  final String text; // Single parameter for both label and hint text
  final double? width; // Optional width parameter
  final Color backgroundColor; // Background color parameter
  final FocusNode? focusNode; // Optional FocusNode parameter
  final VoidCallback? onTap; // Optional onTap callback
  final TextInputAction? textInputAction; // Optional text input action
  final VoidCallback? onEditingComplete; // Optional editing complete callback

  GreyTextBox({
    Key? key,
    required this.nameController,
    this.text = 'Name', // Default value for label and hint text
    this.width, // Optional width
    this.backgroundColor =
        const Color(0xFFE4E8EC), // Default grey background color
    this.focusNode, // Optional FocusNode
    this.onTap, // Optional onTap callback
    this.textInputAction, // Optional text input action
    this.onEditingComplete, // Optional editing complete callback
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
            fontSize: 9,
            color: Color(0xFFA51414), // Adjust the color as needed
          ),
        ),
        const SizedBox(height: 1),
        Container(
          width: width ??
              screenWidth *
                  0.9, // Default to 90% of screen width if width is not provided
          height: 32,
          decoration: BoxDecoration(
            color: backgroundColor, // Use the customizable background color
            borderRadius: BorderRadius.circular(9),
          ),
          child: TextField(
            cursorColor: Colors.black, // Set the cursor color to black
            controller: nameController,
            focusNode: focusNode, // Attach the FocusNode
            onTap: onTap, // Attach the onTap callback
            textInputAction: textInputAction, // Attach the text input action
            onEditingComplete: onEditingComplete, // Attach editing complete callback
            decoration: InputDecoration(
              hintText: text, // Use the same parameter for hint text
              hintStyle: const TextStyle(
                fontSize: 12, // <-- Reduce this value as needed
                color: Colors.black, // Optional: set a color for the hint
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 13), // Center text vertically
            ),
          ),
        ),
      ],
    );
  }
}
