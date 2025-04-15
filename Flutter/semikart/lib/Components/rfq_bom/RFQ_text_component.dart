import 'package:flutter/material.dart';
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/grey_text_box.dart'; // Import the GreyTextBox widget

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

  // Method to validate mandatory fields
  bool _validateFields(int index) {
    final controllerMap = _controllers[index];
    if (controllerMap['partNo']!.text.isEmpty ||
        controllerMap['manufacturer']!.text.isEmpty ||
        controllerMap['quantity']!.text.isEmpty) {
      return false; // Validation failed
    }
    return true; // Validation passed
  }

  // Method to add a new RFQ component with validation
  void _addRFQComponent() {
    // Validate the last component before adding a new one
    if (_rfqComponents.isNotEmpty &&
        !_validateFields(_rfqComponents.length - 1)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Please fill all mandatory fields before adding a new row.'),
          backgroundColor: Color(0xFFA51414),
        ),
      );
      return; // Stop adding a new component
    }

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
      width: double.infinity, // Make the container take full width
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
                text:
                    'Manufacturers Part No*', // Add asterisk to indicate mandatory
                backgroundColor: Colors.white, // Set background color to white
              ),

              SizedBox(height: 10), // Space between rows

              // Manufacturers
              GreyTextBox(
                nameController: controllerMap['manufacturer']!,
                text: 'Manufacturer*', // Add asterisk to indicate mandatory
                backgroundColor: Colors.white, // Set background color to white
              ),

              SizedBox(height: 10), // Space between rows

              // Row for Quantity and Target Price
              Row(
                children: [
                  // Quantity
                  Expanded(
                    flex: 1,
                    child: GreyTextBox(
                      nameController: controllerMap['quantity']!,
                      text: 'Quantity*', // Add asterisk to indicate mandatory
                      backgroundColor:
                          Colors.white, // Set background color to white
                    ),
                  ),
                  SizedBox(
                      width: 30), // Padding between Quantity and Target Price

                  // Target Price
                  Expanded(
                    flex: 1,
                    child: GreyTextBox(
                      nameController: controllerMap['price']!,
                      text: 'Price',
                      backgroundColor:
                          Colors.white, // Set background color to white
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Conditionally Render Delete Button
          if (index >
              0) // Show delete button only for components after the first one
            Positioned(
              top: 0,
              right: 0,
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
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return Container(
      color: Colors.white, // Set the background color to white
      width: screenWidth, // Make the container responsive to screen width
      padding: EdgeInsets.symmetric(
          horizontal: 16), // Horizontal padding for alignment
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add the instruction text
          Padding(
            padding: EdgeInsets.only(bottom: 20), // Padding below the text
            child: Text(
              "Manually enter each product\nrequirement below.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

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
                right:0, // Adjusted from 20 to 15 to move the button 5 pixels right
              ),
              child: RedButton(
                width: screenWidth * 0.25, // Make button width responsive
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
