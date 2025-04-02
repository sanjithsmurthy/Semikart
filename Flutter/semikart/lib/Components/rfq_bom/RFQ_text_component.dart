import 'package:flutter/material.dart';
import '../Commons/red_button.dart'; // Import the RedButton widget
import '../rfq_bom/add_item_manually.dart'; // Import the DeleteButton widget

class RFQTextComponent extends StatefulWidget {
  const RFQTextComponent({super.key});

  @override
  State<RFQTextComponent> createState() => _RFQTextComponentState();
}

class _RFQTextComponentState extends State<RFQTextComponent> {
  // List to hold dynamically added RFQ components
  final List<int> _rfqComponents = [];

  @override
  void initState() {
    super.initState();
    // Add the initial RFQ component
    _addRFQComponent();
  }

  // Method to add a new RFQ component
  void _addRFQComponent() {
    setState(() {
      _rfqComponents.add(_rfqComponents.length + 1);
    });
  }

  // Method to remove an RFQ component
  void _removeRFQComponent(int index) {
    setState(() {
      _rfqComponents.removeAt(index);
      // Rebuild the list to update the numbering
      for (int i = 0; i < _rfqComponents.length; i++) {
        _rfqComponents[i] = i + 1;
      }
    });
  }

  // Method to build the grey RFQ component
  Widget _buildRFQComponent(int index) {
    return Container(
      width: 365, // Fixed width for the grey box
      padding: EdgeInsets.all(16.0), // Padding inside the grey box
      margin: EdgeInsets.only(bottom: 20), // Padding between components
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Number
              Text(
                '$index.', // Dynamically update the number
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
                        width: 150, // Adjusted width for the text field
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
                          10), // Add padding between Quantity and Target Price

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
                        width: 150, // Adjusted width for the text field
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

          // Conditionally Render Delete Button
          if (index >
              1) // Show delete button only for components after the first one
            Positioned(
              top: 0, // Position at the top
              right: 0, // Position at the right corner
              child: IconButton(
                icon:
                    Icon(Icons.delete, color: Color(0xFFA51414)), // Delete icon
                onPressed: () {
                  _removeRFQComponent(
                      index - 1); // Remove the corresponding component
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set the background color to white
      width: 412, // Set the width of the white component
      padding: EdgeInsets.all(8), // Padding from the left
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display all RFQ components
          ..._rfqComponents.map((index) => _buildRFQComponent(index)).toList(),

          // Add Row Button
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15,
                  right: 20), // Spacing between button and last component
              child: RedButton(
                width: 90, // Adjusted width
                height: 34, // Adjusted height
                label: 'Add Row',
                onPressed: _addRFQComponent, // Add a new RFQ component
              ),
            ),
          ),
        ],
      ),
    );
  }
}
