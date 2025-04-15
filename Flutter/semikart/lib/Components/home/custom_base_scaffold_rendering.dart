import 'package:flutter/material.dart';
import '../common/custom_base_scaffold.dart'; // Import CustomBaseScaffold

class CustomBaseScaffoldRendering extends StatelessWidget {
  const CustomBaseScaffoldRendering({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBaseScaffold(
      selectedIndex: 0, // Home screen selected in the bottom nav
      onNavTap: (index) {
        // Handle navigation
        if (index == 1) {
          Navigator.pushNamed(context, '/products');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/search');
        } else if (index == 3) {
          Navigator.pushNamed(context, '/cart');
        } else if (index == 4) {
          Navigator.pushNamed(context, '/profile');
        }
      },
      body: const SizedBox(), // Placeholder for the body
    );
  }
}
