import 'package:flutter/material.dart';
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/grey_text_box.dart'; // Import the GreyTextBox widget

class RFQTextComponent extends StatefulWidget {
  const RFQTextComponent({Key? key, required Null Function(bool isValid) onValidationChanged}) : super(key: key);

  @override
  State<RFQTextComponent> createState() => _RFQTextComponentState();
}

class _RFQTextComponentState extends State<RFQTextComponent> {
  // List to hold dynamically added RFQ components
  final List<int> _rfqComponents = [];
  final List<Map<String, TextEditingController>> _controllers = [];

  @override
  void initState() {
    super.initState();
    _addRFQComponent();
  }

  @override
  void dispose() {
    for (var controllerMap in _controllers) {
      controllerMap.values.forEach((controller) => controller.dispose());
    }
    super.dispose();
  }

  bool _validateFields(int index) {
    final controllerMap = _controllers[index];
    return controllerMap['partNo']!.text.isNotEmpty &&
        controllerMap['manufacturer']!.text.isNotEmpty &&
        controllerMap['quantity']!.text.isNotEmpty;
  }

  void _addRFQComponent() {
    if (_rfqComponents.isNotEmpty &&
        !_validateFields(_rfqComponents.length - 1)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Please fill all mandatory fields before adding a new row.'),
          backgroundColor: Color(0xFFA51414),
        ),
      );
      return;
    }

    setState(() {
      _rfqComponents.add(_rfqComponents.length + 1);
      _controllers.add({
        'partNo': TextEditingController(),
        'manufacturer': TextEditingController(),
        'quantity': TextEditingController(),
        'price': TextEditingController(),
      });
    });
  }

  void _removeRFQComponent(int index) {
    setState(() {
      _rfqComponents.removeAt(index);
      _controllers[index].values.forEach((controller) => controller.dispose());
      _controllers.removeAt(index);
    });
  }

  Widget _buildRFQComponent(int index, double screenWidth) {
    final controllerMap = _controllers[index];
    final double greyBoxPadding = screenWidth * 0.04; // 4% of screen width
    final double greyBoxMarginBottom = screenWidth * 0.05; // 5% of screen width
    final double borderRadius = screenWidth * 0.0375; // 3.75% of screen width
    final double numberFontSize = screenWidth * 0.035; // 3.5% of screen width
    final double sizedBoxHeight = screenWidth * 0.013; // 1.3% of screen width
    final double rowSizedBoxWidth = screenWidth * 0.075; // 7.5% of screen width
    final double deleteButtonIconSize =
        screenWidth * 0.06; // 6% of screen width

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(greyBoxPadding),
      margin: EdgeInsets.only(bottom: greyBoxMarginBottom),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${index + 1}.',
                style: TextStyle(
                  fontSize: numberFontSize,
                  color: const Color(0xFFA51414),
                ),
              ),
              SizedBox(height: sizedBoxHeight),
              GreyTextBox(
                nameController: controllerMap['partNo']!,
                text: 'Manufacturers Part No*',
                backgroundColor: Colors.white,
              ),
              SizedBox(height: sizedBoxHeight * 2),
              GreyTextBox(
                nameController: controllerMap['manufacturer']!,
                text: 'Manufacturer*',
                backgroundColor: Colors.white,
              ),
              SizedBox(height: sizedBoxHeight * 2),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GreyTextBox(
                      nameController: controllerMap['quantity']!,
                      text: 'Quantity*',
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: rowSizedBoxWidth),
                  Expanded(
                    flex: 1,
                    child: GreyTextBox(
                      nameController: controllerMap['price']!,
                      text: 'Price',
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (index > 0)
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Color(0xFFA51414)),
                onPressed: () => _removeRFQComponent(index),
                iconSize: deleteButtonIconSize,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final instructionTextFontSize = screenWidth * 0.05; // 5% of screen width
    final instructionPaddingBottom = screenWidth * 0.05; // 5% of screen width
    final addRowButtonWidth = screenWidth * 0.25; // 25% of screen width
    final addRowButtonHeight = screenWidth * 0.085; // 8.5% of screen width
    final addRowButtonPaddingTop = screenWidth * 0.04; // 4% of screen width
    final addRowButtonPaddingRight = screenWidth * 0.04; // 4% of screen width
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width

    return Container(
      color: Colors.white,
      width: screenWidth,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: instructionPaddingBottom),
            child: Text(
              "Manually enter each product requirement below.",
              style: TextStyle(
                fontSize: instructionTextFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          ..._rfqComponents.asMap().entries.map((entry) {
            int index = entry.key;
            return _buildRFQComponent(index, screenWidth);
          }).toList(),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: addRowButtonPaddingTop ,
                right: addRowButtonPaddingRight - 15,
              ),
              child: RedButton(
                width: addRowButtonWidth,
                height: addRowButtonHeight,
                label: 'Add Row',
                onPressed: _addRFQComponent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
