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
          // Cart bag image
          Positioned(
            left: 121,
            top: 0,
            child: Image.asset(
              'public/assets/images/cart_bag.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          // Empty cart text
          Positioned(
            left: 75,
            top: 127,
            child: Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Product Sans',
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          // Existing button
          Positioned(
            left: 82,
            bottom: 0,
            child: RedButton(
              label: "Explore Categories",
              onPressed: () {
                print('Explore Categories pressed');
              },
              // variant: 'small',
              width: 179,
            ),
          ),
        ],
      ),
    );
  }
}