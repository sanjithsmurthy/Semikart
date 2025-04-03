import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get the maximum width available
        final maxWidth = constraints.maxWidth;

        // Dynamically calculate container width and height
        final containerWidth = maxWidth > 355 ? 355.0 : maxWidth; // Limit width to 355 or less
        final containerHeight = containerWidth * 0.72; // Maintain aspect ratio for height

        // Dynamically calculate font size based on container width
        final fontSize = containerWidth * 0.04; // Font size is 4% of container width

        final textStyle = TextStyle(
          fontSize: fontSize, // Dynamically calculated font size
          fontFamily: 'Product Sans',
          fontWeight: FontWeight.normal,
          color: Color(0xFF000000),
          letterSpacing: -0.14,
          height: 1.5, // Adjusted for better fit
        );

        return Container(
          width: containerWidth,
          height: containerHeight,
          padding: EdgeInsets.symmetric(horizontal: containerWidth * 0.07, vertical: containerHeight * 0.06),
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
                  SizedBox(width: containerWidth * 0.35, child: Text('Order ID:', style: textStyle)),
                  Expanded(child: Text('50846T2023121830764', style: textStyle)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: containerWidth * 0.35, child: Text('Transaction ID:', style: textStyle)),
                  Expanded(child: Text('T2023121830764', style: textStyle)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: containerWidth * 0.35, child: Text('Order Date:', style: textStyle)),
                  Expanded(child: Text('18-Dec-2023 4:20:55 PM', style: textStyle)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: containerWidth * 0.35, child: Text('Order Status:', style: textStyle)),
                  Expanded(child: Text('Order Cancelled', style: textStyle)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: containerWidth * 0.35, child: Text('Opted Shipment\nType:', style: textStyle)),
                  Expanded(child: Text('-', style: textStyle)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: containerWidth * 0.35, child: Text('AWB Number:', style: textStyle)),
                  Expanded(child: Text('-', style: textStyle)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: containerWidth * 0.35, child: Text('Shipped via:', style: textStyle)),
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