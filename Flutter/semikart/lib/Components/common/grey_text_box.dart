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
    final screenWidth = MediaQuery.of(context).size.width;

    final double textBoxHeight = 32.0;
    final double labelFontSize = 9.0;
    final double reducedTextBoxHeight = textBoxHeight * 0.9;
    final double reducedHintFontSize = labelFontSize * 0.85;

    // Dynamically scale vertical padding as a fraction of the box height
    final double verticalPadding = reducedTextBoxHeight * 0.25; // Adjust this factor as needed

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFFA51414),
          ),
        ),
        const SizedBox(height: 1),
        Container(
          width: width ?? screenWidth * 0.9,
          height: reducedTextBoxHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(9),
          ),
          child: TextField(
            cursorColor: Colors.black,
            controller: nameController,
            focusNode: focusNode,
            onTap: onTap,
            textInputAction: textInputAction,
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              hintText: text,
              hintStyle: TextStyle(
                fontSize: reducedHintFontSize*1.3,
                color: Colors.grey.shade500,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: verticalPadding*2, // Dynamically scaled
              ),
            ),
          ),
        ),
      ],
    );
  }
}
