import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package
import 'ship_bill.dart'; // Import the ShipBillForm widget

class EditTextBox extends StatelessWidget {
  final String? address1;
  final String? address2;
  final String? title;
  final VoidCallback? onSave;
  final VoidCallback? onEdit;

  const EditTextBox({
    super.key,
    this.address1,
    this.address2,
    this.title,
    this.onSave,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
              children: [
                Text(
                  title ?? 'Billing Address',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  (address1?.isNotEmpty == true || address2?.isNotEmpty == true)
                      ? '${address1 ?? ''}${address1?.isNotEmpty == true && address2?.isNotEmpty == true ? ', ' : ''}${address2 ?? ''}'
                      : 'Your ${title?.toLowerCase() ?? 'billing'} address is not found',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
            GestureDetector(
            onTap: () {
              if (onEdit != null) {
                onEdit!();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditPage()),
                );
              }
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