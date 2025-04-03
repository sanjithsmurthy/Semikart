import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package
import 'bottom_bar.dart'; // Import the BottomNavBar for navigation
import 'edit_textbox.dart'; // Import the EditTextBox widget
import 'edit_textbox2.dart'; // Import the EditTextBox2 widget

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensure the header fills the entire screen width
      color: Colors.white,
      height: 66.0, // Increased height to accommodate additional padding
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0), // Added vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Icon
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            iconSize: 35.0,
            onPressed: () {},
          ),
          // Add spacing between the menu icon and the logo
          const SizedBox(width: 15.0),
          // Logo (Clickable)
          Flexible(
            child: Align(
              alignment: Alignment.centerLeft, // Align the logo closer to the menu icon
              child: GestureDetector(
                onTap: () {
                  // Navigate to the home tab of the bottom bar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBar(), // Redirect to BottomNavBar
                    ),
                  );
                },
                child: Image.asset(
                  'public/assets/images/semikart_logo_medium.png',
                  height: 20.0, // Fixed height for the logo
                  fit: BoxFit.contain, // Ensure the logo scales properly
                ),
              ),
            ),
          ),
          // Right-side Icons
          Row(
            mainAxisSize: MainAxisSize.min, // Prevents the row from taking extra space
            children: [
              IconButton(
                icon: Image.asset('public/assets/images/whatsapp_icon.png'),
                iconSize: 20.0, // Reduced size for WhatsApp icon
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.phone, color: Colors.black),
                iconSize: 27.0, // Reduced size for phone icon
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(66.0); // Updated height to match the new padding
}

// EditPage Class
class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool isChecked = false; // State for the checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Adjust height as needed
        child: CombinedAppBar(
          title: "Payment",
          onBackPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16), // Add spacing
            const EditTextBox(), // Use the EditTextBox widget here
            const SizedBox(height: 16), // Add spacing
            CheckboxListTile(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value ?? false; // Update the checkbox state
                });
              },
              title: const Text(
                "Billing Address same as shipping address",
                style: TextStyle(fontSize: 16),
              ),
              controlAffinity: ListTileControlAffinity.leading, // Place the checkbox on the left
              activeColor: Color(0xFFA51414), // Set the tick color to red (#A51414)
              contentPadding: EdgeInsets.zero, // Remove extra padding
            ),
            const SizedBox(height: 16), // Add spacing
            const EditTextBox2(), // Add the EditTextBox2 widget below the checkbox
          ],
        ),
      ),
    );
  }
}

// CombinedAppBar Widget
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
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjust height dynamically
        children: [
          const Header(), // Place the Header widget at the top
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: SvgPicture.asset(
                'public/assets/images/back.svg', // Path to the back.svg file
                color: const Color(0xFFA51414), // Apply the custom color
              ),
              iconSize: 24.0, // Set the size of the SVG
              onPressed: onBackPressed,
            ),
            title: Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150); // Adjust height dynamically
}