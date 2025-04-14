import 'package:flutter/material.dart';

class Breadcrumbs extends StatelessWidget {
  final List<BreadcrumbItem> items;

  const Breadcrumbs({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          GestureDetector(
            onTap: items[i].onTap,
            child: Text(
              items[i].label,
              style: TextStyle(
                color: i == items.length - 1 ? const Color(0xFFA51414) : Colors.black,
                fontWeight: i == items.length - 1 ? FontWeight.bold : FontWeight.normal,
fontSize: 14, // Set font size to 14
                fontFamily: 'Product Sans', // Use Product Sans font
                decoration: i == items.length - 1 ? TextDecoration.none : TextDecoration.underline,
              ),
            ),
          ),
          if (i < items.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text('>', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
        ],
      ],
    );
  }
}

class BreadcrumbItem {
  final String label;
  final VoidCallback onTap;

  BreadcrumbItem({required this.label, required this.onTap});
}