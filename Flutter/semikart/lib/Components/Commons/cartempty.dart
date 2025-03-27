import 'package:flutter/material.dart';
import 'red_button.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342,
      height: 234,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF), // White background
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 82,
            bottom: 20, // Space from bottom
            child: RedButton(
              label: "Explore Categories",
              onPressed: () {
                print('Explore Categories pressed');
              },
              variant: 'small', // 16px font size
              width: 179, // Specified width
            ),
          ),
        ],
      ),
    );
  }
}