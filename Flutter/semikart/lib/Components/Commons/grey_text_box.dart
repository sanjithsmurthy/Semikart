import 'package:flutter/material.dart';

class GreyTextBox extends StatelessWidget {
  final TextEditingController nameController;

  GreyTextBox({Key? key, required this.nameController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set the background color to white
      height: 100,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFFA51414), // Adjust the color as needed
            ),
          ),
          const SizedBox(height: 2),
          Container(
            width: 375,
            height: 41.54,
            decoration: BoxDecoration(
              color: Color(0xFFE4E8EC), // Grey background color
              borderRadius: BorderRadius.circular(9),
            ),
            child: TextField(
              cursorColor: Colors.black, // Set the cursor color to black
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Username', // Placeholder text
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}