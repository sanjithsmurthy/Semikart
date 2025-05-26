import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/red_button.dart';
import '../home/order_history_item.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  int totalOrders = 0;
  int ongoingOrders = 0;
  String? orderStatus;

  DateTime? fromDate;
  DateTime? toDate;

  Future<void> _selectDate(BuildContext context, bool isFromDate, {DateTime? firstDate}) async {
    final DateTime initialDate = isFromDate ? (fromDate ?? DateTime.now()) : (toDate ?? DateTime.now());
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFFA51414), // Header background color
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFA51414), // Circle and selected date color
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Button text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        if (isFromDate) {
          fromDate = pickedDate;
          if (toDate != null && toDate!.isBefore(pickedDate)) {
            toDate = null; // Reset toDate if it is before new fromDate
          }
        } else {
          toDate = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Reference screen dimensions (same as cart_page)
    const double refWidth = 412.0;
    const double refHeight = 917.0;

    // Calculate scaling factors
    final widthScale = screenWidth / refWidth;
    final heightScale = screenHeight / refHeight;
    final scale = widthScale < heightScale ? widthScale : heightScale;

    // Scaled text sizes
    final double headingTextSize = 16.0 * scale;
    final double normalTextSize = 14.0 * scale;
    final double smallTextSize = 12.0 * scale;
    final double labelTextSize = 11.0 * scale;

    // Original variables - replace with scaled versions where needed
    final double containerWidth = screenWidth > 600 ? 500 : screenWidth * 0.8;
    final double padding = screenWidth > 600 ? 20 : 16;
    final double borderRadius = screenWidth > 600 ? 12 : 8;
    
    // Use this instead of the old fontSize variable
    // final double fontSize = screenWidth > 600 ? 14 : 12;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOrderChip('Total Orders', totalOrders.toString(), Icons.receipt),
                    SizedBox(width: screenWidth * 0.05),
                    _buildOrderChip('Ongoing Orders', ongoingOrders.toString(), Icons.local_shipping),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text('Search', style: TextStyle(fontSize: normalTextSize)),
              SizedBox(height: screenHeight * 0.005),
              TextFormField(
                cursorColor: const Color(0xFFA51414),
                style: TextStyle(fontSize: normalTextSize * 0.9), // Slightly smaller text
                decoration: InputDecoration(
                  hintText: 'Enter search term',
                  isDense: true, // Makes the field more compact
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 13, 
                    vertical: 13, // Reduced vertical padding
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: const BorderSide(
                      color: Color(0xFFA51414),
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: const BorderSide(
                      color: Color(0xFFA51414),
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: const BorderSide(
                      color: Color(0xFFA51414),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Changed from spaceAround to spaceBetween
                children: [
                  // From Date - extreme left
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('From Date', style: TextStyle(fontSize: normalTextSize)),
                      SizedBox(height: screenHeight * 0.003),
                      SizedBox(
                        width: containerWidth * 0.55, // Adjusted width
                        child: InkWell(
                          onTap: () => _selectDate(context, true),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              isDense: true, // Makes the field more compact
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, 
                                vertical: 8, // Reduced vertical padding for smaller height
                              ),
                              hintText: 'DD/MM/YYYY',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                              ),
                            ),
                            child: Text(
                              fromDate != null
                                  ? DateFormat('dd/MM/yyyy').format(fromDate!)
                                  : 'DD/MM/YYYY',
                              style: TextStyle(fontSize: normalTextSize),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // To Date - extreme right
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('To Date', style: TextStyle(fontSize: normalTextSize)),
                      SizedBox(height: screenHeight * 0.005),
                      SizedBox(
                        width: containerWidth * 0.55, // Adjusted width
                        child: InkWell(
                          onTap: fromDate == null ? null : () => _selectDate(context, false, firstDate: fromDate),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              isDense: true, // Makes the field more compact
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, 
                                vertical: 8, // Reduced vertical padding for smaller height
                              ),
                              hintText: 'DD/MM/YYYY',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                              ),
                            ),
                            child: Text(
                              toDate != null
                                  ? DateFormat('dd/MM/yyyy').format(toDate!)
                                  : 'DD/MM/YYYY',
                              style: TextStyle(fontSize: normalTextSize),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Text('Order Status', style: TextStyle(fontSize: normalTextSize)),
              SizedBox(height: screenHeight * 0.005),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: const Color(0xFFA51414),
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: const Color(0xFFA51414),
                      ),
                ),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFA51414)),
                  iconSize: 24,
                  elevation: 4,
                  menuMaxHeight: screenHeight * 0.4, // Constrain menu height
                  decoration: InputDecoration(
                    isDense: true, // Add this to make it more compact
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8, // Reduced padding to match date fields
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: const BorderSide(
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: Color(0xFFA51414),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: Color(0xFFA51414),
                      ),
                    ),
                  ),
                  dropdownColor: Colors.white,
                  value: orderStatus,
                  hint: Text('Select', style: TextStyle(fontSize: normalTextSize)),
                  items: const <String>[
                    // 'Select',
                    'Order Placed',
                    'Order Accepted',
                    'Contacted Supplier',
                    'In Transit',
                    'Custom Clearance',
                    'In SemiKart Fulfillment Center',
                    'Order Shipped',
                    'Order Partially Shipped',
                    'Order Delivered',
                    'Order Partially Delivered',
                    'Order Cancelled'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: normalTextSize)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      orderStatus = newValue;
                    });
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              // Replace the Center wrapper with a Row to push button to right
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Push to right side
                children: [
                  SizedBox(
                    width: screenWidth * 0.26,  // Keep original width
                    child: RedButton(
                      label: 'Search',
                      height: screenHeight * 0.035,
                      onPressed: () {
                        // Implement search functionality here
                        print('Search button pressed');
                      },
                    ),
                  ),
                ],
              ),

              // SizedBox(height: screenHeight * 0.01), // Keep original spacing

              // Then the Orders heading below it
              // Padding(
              //   padding: EdgeInsets.only(
              //     // top: screenHeight * 0.001,
              //     // bottom: screenHeight * 0.001,
              //   ),
                // child: 
                Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: headingTextSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              // ),
              SizedBox(height: screenHeight * 0.0005), // 1px space between "Orders" and the first container
              OrderHistoryItem(
                orderId: '1. 50486T2025040942440',
                orderStatus: 'Order Cancelled',
                transactionId: 'T2025040942440',
                orderDate: '09-Apr-2025 6:50:06 PM',
                poDate: ' ',
                customerPo: ' ',
                paymentStatus: 'PENDING',
                amount: '15484.43',
                onMakePayment: () {
                  // Implement payment functionality here
                  print('Make Payment button pressed');
                },
              ),
              SizedBox(height: screenHeight * 0.0005), // 1px space between containers
              OrderHistoryItem(
                orderId: '2. 50486T2025040948976',
                orderStatus: 'Order Cancelled',
                transactionId: 'T2025040842411',
                orderDate: '08-Apr-2025 12:48:24 PM',
                poDate: ' ',
                customerPo: ' ',
                paymentStatus: 'PENDING',
                amount: '15479.80',
                onMakePayment: () {
                  // Implement payment functionality here
                  print('Make Payment button pressed');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderChip(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Color(0xFFA51414)),
          SizedBox(width: 6),
          Text(
            '$label: ',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFA51414),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      title: 'Semikart',
      theme: ThemeData(
        primaryColor: const Color(0xFFA51414),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFA51414), // Cursor color
          selectionColor: Color(0xFFA51414), // Highlight color for selected text
          selectionHandleColor: Color(0xFFA51414), // Handle color for text selection
        ),
      ),
      home: const OrderHistory(),
    ),
  );
}