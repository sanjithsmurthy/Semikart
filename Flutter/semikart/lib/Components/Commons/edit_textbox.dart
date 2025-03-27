import 'package:flutter/material.dart';

class EditTextBox extends StatelessWidget {
  final String title;
  final String address;
  final VoidCallback onEdit;

  const EditTextBox({
    super.key,
    required this.title,
    required this.address,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5), // Light grey background
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: Icon(
              Icons.edit,
              color: Color(0xFFA51414), // Red color for the edit icon
            ),
          ),
        ],
      ),
    );
  }
}