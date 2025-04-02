import 'package:flutter/material.dart';

class EditTextBox extends StatelessWidget {
  const EditTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Shipping Address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Magadi Main Rd, next to Prasanna Theatre, Cholourpalya, Bengaluru, Karnataka 560023',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditPage()),
              );
            },
            child: const Icon(
              Icons.edit,
              color: Color(0xFFA51414), // Red color for the edit icon
            ),
          ),
        ],
      ),
    );
  }
}

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Address"),
        backgroundColor: const Color(0xFFA51414),
      ),
      body: const Center(
        child: Text(
          "This is the Edit Address Page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}