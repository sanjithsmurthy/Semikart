import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 56.0, // Standard AppBar height
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Icon
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
          // Logo
          Image.asset(  
            'public/assets/images/semikart_logo_medium.png',
            height: 40.0, // Fixed height for the logo
          ),
          // Right-side Icons
          Row(
            children: [
              IconButton(
                icon: Image.asset('public/assets/images/whatsapp_icon.png'),
                iconSize: 24.0, // Reduced size for WhatsApp icon
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.phone, color: Colors.black),
                iconSize: 20.0, // Reduced size for phone icon
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0); // Standard AppBar height
}