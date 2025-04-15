// import 'package:flutter/material.dart';
// import '../cart/cart_page.dart'; // Import CartPage
// import '../common/header.dart'; // Import the unified Header
// import '../profile/profile_screen.dart'; // Import ProfileScreen
// import '../home/custom_base_scaffold_rendering.dart'; // Import HomeScreen

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int _selectedIndex = 0;

//   // List of pages for navigation
//   final List<Widget> _pages = [
//      HomePage(), // Navigate to HomeScreen
//     const PlaceholderPage(title: 'Products Page'), // Placeholder for ProductsPage
//     const PlaceholderPage(title: 'Search Page'), // Placeholder for SearchPage
//     CartPage(), // Navigate to CartPage
//     const ProfileScreen(), // Navigate to ProfileScreen
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index; // Update the selected index
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: Header(
//         showBackButton: _selectedIndex != 0, // Show back button for non-home pages
//         title: _getPageTitle(_selectedIndex), // Set the title based on the selected page
//         onBackPressed: () {
//           setState(() {
//             _selectedIndex = 0; // Navigate back to HomeScreen
//           });
//         },
//         onLogoTap: () {
//           setState(() {
//             _selectedIndex = 0; // Navigate to HomeScreen when logo is tapped
//           });
//         },
//       ),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _pages, // Render the selected page
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color(0xFFA51414), // Updated selected item color to #A51414
//         unselectedItemColor: Colors.grey, // Unselected item color
//         backgroundColor: Colors.white, // Set the background color to white
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.inventory),
//             label: 'Products',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search), // Search icon
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper method to get the title for Header
//   String? _getPageTitle(int index) {
//     switch (index) {
//       case 1:
//         return 'Products';
//       case 2:
//         return 'Search';
//       case 3:
//         return 'Your Cart';
//       case 4:
//         return 'Profile';
//       default:
//         return null; // No title for HomeScreen
//     }
//   }
// }

// // Placeholder widget for pages that are not ready yet
// class PlaceholderPage extends StatelessWidget {
//   final String title;

//   const PlaceholderPage({Key? key, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }