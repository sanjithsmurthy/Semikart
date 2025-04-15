import 'package:flutter/material.dart';
import 'base_scaffold.dart'; // Import BaseScaffold

class CustomBaseScaffold extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavTap;
  final Widget body;

  const CustomBaseScaffold({
    super.key,
    required this.selectedIndex,
    required this.onNavTap,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(); // Use BaseScaffold directly
  }
}