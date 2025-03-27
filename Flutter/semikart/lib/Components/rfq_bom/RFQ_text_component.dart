import 'package:flutter/material.dart';
import '../Commons/red_button.dart'; // Import the RedButton widget

class RFQTextComponent extends StatelessWidget {
  const RFQTextComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 365, // Fixed width for the grey box
          height: 260, // Fixed height for the grey box
          padding: EdgeInsets.all(16.0), // Padding inside the grey box
          decoration: BoxDecoration(
            color: Color(0xFFD9D9D9), // Set the square area color to #D9D9D9
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Number
              Text(
                '1.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFA51414), // Normal color, no bold
                ),
              ),
              SizedBox(height: 5), // Space between number and label

              // Manufacturers Part No
              Text(
                'Manufacturers Part No*',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFA51414), // Normal color, no bold
                ),
              ),
              SizedBox(height: 5), // Space between label and text field
              SizedBox(
                width: 345, // Set width for the text field
                height: 35, // Set height for the text field
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Set corner radius to 10
                      borderSide: BorderSide.none, // Remove the border
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    filled: true,
                    fillColor: Color(0xFFF9F9F9),
                    hintText: 'Enter part number',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10), // Space between rows

              // Manufacturers
              Text(
                'Manufacturers*',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFA51414), // Normal color, no bold
                ),
              ),
              SizedBox(height: 5), // Space between label and text field
              SizedBox(
                width: 345, // Set width for the text field
                height: 35, // Set height for the text field
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Set corner radius to 10
                      borderSide: BorderSide.none, // Remove the border
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    filled: true,
                    fillColor: Color(0xFFF9F9F9),
                    hintText: 'Enter manufacturer',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10), // Space between rows

              // Row for Quantity and Target Price
              Row(
                children: [
                  // Quantity
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quantity*',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFA51414), // Normal color, no bold
                        ),
                      ),
                      SizedBox(height: 5), // Space between label and text field
                      SizedBox(
                        width: 160, // Set width for the text field
                        height: 35, // Set height for the text field
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Set corner radius to 10
                              borderSide: BorderSide.none, // Remove the border
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            filled: true,
                            fillColor: Color(0xFFF9F9F9),
                            hintText: 'Enter quantity',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width:
                          10), // Add 10 pixels of space between Quantity and Target Price

                  // Target Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Target Price',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFA51414), // Normal color, no bold
                        ),
                      ),
                      SizedBox(height: 5), // Space between label and text field
                      SizedBox(
                        width: 160, // Set width for the text field
                        height: 35, // Set height for the text field
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Set corner radius to 10
                              borderSide: BorderSide.none, // Remove the border
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            filled: true,
                            fillColor: Color(0xFFF9F9F9),
                            hintText: 'Enter price',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        // Add the RedButton below the square box
        Positioned(
          top: 280, // Position the button below the square box
          right: 10, // Align to the right corner
          child: RedButton(
            width: 90, // Adjusted width
            height: 34, // Adjusted height
            label: 'Add Row',
            onPressed: () {
              print('Red button pressed!');
            },
          ),
        ),
      ],
    );
  }
}
