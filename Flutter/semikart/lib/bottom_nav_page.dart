import 'package:flutter/material.dart';
import 'Components/common/base_scaffold.dart'; // Import BaseScaffold
import 'Components/home/home_screen.dart'; // Import HomePage
import 'Components/cart/cart_page.dart'; // Import CartPage
import 'Components/profile/profile_screen.dart'; // Import ProfilePage

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    const ProductsPage(),
    const SearchPage(),
    CartPage(),
    ProfileScreen(),
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      selectedIndex: _selectedIndex,
      onNavTap: _onNavTap,
    );
  }
}

// Placeholder for ProductsPage
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Products Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Placeholder for SearchPage
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Search Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}