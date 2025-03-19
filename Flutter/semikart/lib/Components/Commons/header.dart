import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 412,
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          Image.asset(
            'public/assets/images/semikart_logo_medium.svg',
            height: 40,
          ),
          Row(
            children: [
              IconButton(
                icon: Image.asset('public/assets/images/whatsapp_icon.png'),
                iconSize: 30,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.phone),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}