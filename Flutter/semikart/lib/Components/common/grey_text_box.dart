import 'package:flutter/material.dart';

class GreyTextBox extends StatelessWidget {
  final TextEditingController nameController;
  final String text; // Single parameter for both label and hint text
  final double? width; // Optional width parameter
  final double? height; // Optional height parameter
  final Color backgroundColor; // Background color parameter
  final FocusNode? focusNode; // Optional FocusNode parameter
  final VoidCallback? onTap; // Optional onTap callback
  final TextInputAction? textInputAction; // Optional text input action
  final VoidCallback? onEditingComplete; // Optional editing complete callback
  final double inputFontSize; // New parameter for typed text font size

  GreyTextBox({
    Key? key,
    required this.nameController,
    this.text = 'Name', // Default value for label and hint text
    this.width, // Optional width
    this.height, // Optional height
    this.backgroundColor =
        const Color(0xFFE4E8EC), // Default grey background color
    this.focusNode, // Optional FocusNode
    this.onTap, // Optional onTap callback
    this.textInputAction, // Optional text input action
    this.onEditingComplete, // Optional editing complete callback
    this.inputFontSize = 12.0, // Default font size for typed text << NEW
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double defaultTextBoxHeight = 32.0;
    final double labelFontSize = 9.0; // This is for the label above the box
    final double reducedDefaultTextBoxHeight = defaultTextBoxHeight * 0.9;
    // Hint font size can be different from input text font size
    final double hintFontSize = inputFontSize * 0.95; // Slightly smaller than input text

    final double currentTextBoxHeight = height ?? reducedDefaultTextBoxHeight;

    // Adjust vertical padding to help with vertical centering.
    // This might need fine-tuning based on the font and box height.
    // A smaller fixed padding or one calculated to center the specific inputFontSize.
    final double verticalPadding = (currentTextBoxHeight - inputFontSize - 4) / 2; // Attempt to center based on font size, adjust '4' as needed for line height buffer

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text, // This is the label text above the box
          style: TextStyle(
            fontSize: labelFontSize, // Keep label font size as is
            color: const Color(0xFFA51414),
          ),
        ),
        const SizedBox(height: 1),
        Container(
          width: width ?? screenWidth * 0.9,
          height: currentTextBoxHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(9),
          ),
          child: TextField(
            cursorColor: Colors.black,
            cursorWidth: 1.5, // Set cursor width << NEW
            controller: nameController,
            focusNode: focusNode,
            onTap: onTap,
            textInputAction: textInputAction,
            onEditingComplete: onEditingComplete,
            textAlignVertical: TextAlignVertical.center, // Helps in vertical centering << NEW
            style: TextStyle(
              fontSize: inputFontSize, // Font size for the typed text << NEW
              color: Colors.black, // Color for the typed text
            ),
            decoration: InputDecoration(
              hintText: text, // Hint text inside the box
              hintStyle: TextStyle(
                fontSize: hintFontSize, // Use a potentially different size for hint
                color: Colors.grey.shade500,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                // Adjust vertical padding. Ensure it's not negative.
                vertical: verticalPadding > 0 ? verticalPadding : 4.0, // Use calculated or a minimum padding
              ),
              isCollapsed: true, // Helps remove some default internal padding of TextField
            ),
          ),
        ),
      ],
    );
  }
}
