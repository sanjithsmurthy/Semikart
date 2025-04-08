import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package
import 'ship_bill.dart'; // Import the ShipBillForm widget

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
                  'Billing Address',
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Adjust height as needed
        child: CombinedAppBar(
          title: "Edit Address",
          onBackPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      body: const ShipBillForm(), // Display the ShipBillForm widget here
    );
  }
}

// Combined AppBar Widget
class CombinedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;

  const CombinedAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'public/assets/images/back.svg',
          color: const Color(0xFFA51414),
        ),
        iconSize: 24.0,
        onPressed: onBackPressed,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150); // Adjust height dynamically
}