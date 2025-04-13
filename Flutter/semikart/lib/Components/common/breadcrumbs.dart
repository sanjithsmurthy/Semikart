import 'package:flutter/material.dart';

class Breadcrumbs extends StatelessWidget {
  final List<BreadcrumbItem> items; // List of breadcrumb items

  const Breadcrumbs({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          GestureDetector(
            onTap: items[i].onTap, // Navigate to the corresponding page
            child: Text(
              items[i].label,
              style: TextStyle(
                color: i == items.length - 1
                    ? Colors.red // Highlight the last breadcrumb
                    : Colors.black,
                fontWeight: i == items.length - 1 ? FontWeight.bold : FontWeight.normal,
                decoration: i == items.length - 1 ? TextDecoration.none : TextDecoration.underline,
              ),
            ),
          ),
          if (i < items.length - 1) // Add a separator except for the last item
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                '>',
                style: TextStyle(color: Colors.black),
              ),
            ),
        ],
      ],
    );
  }
}

class BreadcrumbItem {
  final String label; // Name of the breadcrumb
  final VoidCallback onTap; // Action when the breadcrumb is clicked

  BreadcrumbItem({required this.label, required this.onTap});
}