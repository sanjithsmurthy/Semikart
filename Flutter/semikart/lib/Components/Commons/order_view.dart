import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final containerWidth = maxWidth > 355 ? 355.0 : maxWidth;

        const textStyle = TextStyle(
          fontSize: 14,
          fontFamily: 'Product Sans',
          fontWeight: FontWeight.normal,
          color: Color(0xFF000000), // Changed from Colors.black to specific hex
          letterSpacing: -0.14,
          height: 2.0, // Adjusted for better fit
        );

        return Container(
          width: 355,
          height: 256,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 124, child: Text('Order ID:', style: textStyle)),
                  Expanded(child: Text('50846T2023121830764', style: textStyle)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 124, child: Text('Transaction ID:', style: textStyle)),
                  Expanded(child: Text('T2023121830764', style: textStyle)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 124, child: Text('Order Date:', style: textStyle)),
                  Expanded(child: Text('18-Dec-2023 4:20:55 PM', style: textStyle)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 124, child: Text('Order Status:', style: textStyle)),
                  Expanded(child: Text('Order Cancelled', style: textStyle)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 124, child: Text('Opted Shipment\nType:', style: textStyle)),
                  Expanded(child: Text('-', style: textStyle)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 124, child: Text('AWB Number:', style: textStyle)),
                  Expanded(child: Text('-', style: textStyle)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 124, child: Text('Shipped via:', style: textStyle)),
                  Expanded(child: Text('-', style: textStyle)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}