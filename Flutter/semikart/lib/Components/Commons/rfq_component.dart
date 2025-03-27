import 'package:flutter/material.dart';
import 'red_button.dart';

class RFQComponent extends StatelessWidget {
  const RFQComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333,
      height: 99,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),  // Added white background
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              'public/assets/images/RFQ.png',
              width: 99,
              height: 99,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: 130,
            top: 12,
            child: Container(
              width: 165,
              height: 23,
              child: Text(
                'Request for quote',  // Changed from 'Request For Quote' to match requirement
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.normal,
                  color: Color(0xFFA51414),
                ),
              ),
            ),
          ),
          Positioned(
            left: 147,
            top: 50.55,
            child: SizedBox(
              width: 124,
              child: RedButton(
                label: "Submit RFQ",
                onPressed: () {
                  print('RFQ button pressed');
                },
                variant: 'small',  // Added variant parameter for 16px font size
                width: 124,        // Explicit width
              ),
            ),
          ),
        ],
      ),
    );
  }
}