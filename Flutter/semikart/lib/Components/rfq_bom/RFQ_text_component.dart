import 'package:flutter/material.dart';
import '../Commons/red_button.dart'; // Import the RedButton widget
import '../Commons/grey_text_box.dart'; // Import the GreyTextBox widget

class RFQTextComponent extends StatefulWidget {
  const RFQTextComponent({super.key});

  @override
  State<RFQTextComponent> createState() => _RFQTextComponentState();
}

class _RFQTextComponentState extends State<RFQTextComponent> {
  // List to hold dynamically added RFQ components
  final List<int> _rfqComponents = [];
  final List<Map<String, TextEditingController>> _controllers =
      []; // Controllers for each text box

  @override
  void initState() {
    super.initState();
    // Add the initial RFQ component
    _addRFQComponent();
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controllerMap in _controllers) {
      controllerMap.values.forEach((controller) => controller.dispose());
    }
    super.dispose();
  }

  // Method to add a new RFQ component
  void _addRFQComponent() {
    setState(() {
      _rfqComponents.add(_rfqComponents.length + 1);
      _controllers.add({
        'partNo': TextEditingController(),
        'manufacturer': TextEditingController(),
        'quantity': TextEditingController(),
        'price': TextEditingController(),
      }); // Add a new set of controllers for each text box
    });
  }

  // Method to remove an RFQ component
  void _removeRFQComponent(int index) {
    setState(() {
      _rfqComponents.removeAt(index);
      _controllers[index].values.forEach(
          (controller) => controller.dispose()); // Dispose the controllers
      _controllers.removeAt(index); // Remove the controllers
    });
  }

  // Method to build the grey RFQ component
  Widget _buildRFQComponent(int index) {
    final controllerMap =
        _controllers[index]; // Get the controllers for this component

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
                '${index + 1}.', // Dynamically update the number
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFA51414), // Normal color, no bold
                ),
              ),
              SizedBox(height: 5), // Space between number and label

              // Manufacturers Part No
              GreyTextBox(
                nameController: controllerMap['partNo']!,
                text: 'Enter part number',
              ),

              SizedBox(height: 10), // Space between rows

              // Manufacturers
              GreyTextBox(
                nameController: controllerMap['manufacturer']!,
                text: 'Enter manufacturer',
              ),

              SizedBox(height: 10), // Space between rows

              // Row for Quantity and Target Price
              Row(
                children: [
                  // Quantity
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GreyTextBox(
                        nameController: controllerMap['quantity']!,
                        text: 'Enter quantity',
                        width: 150, // Adjusted width for the text field
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
                      GreyTextBox(
                        nameController: controllerMap['price']!,
                        text: 'Enter price',
                        width: 150, // Adjusted width for the text field
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Conditionally Render Delete Button
          if (index >
              0) // Show delete button only for components after the first one
            Positioned(
              top: 0, // Position at the top
              right: 0, // Position at the right corner
              child: IconButton(
                icon:
                    Icon(Icons.delete, color: Color(0xFFA51414)), // Delete icon
                onPressed: () {
                  _removeRFQComponent(
                      index); // Remove the corresponding component
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
          ..._rfqComponents.asMap().entries.map((entry) {
            int index = entry.key;
            return _buildRFQComponent(index);
          }).toList(),

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
