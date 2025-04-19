import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import '../common/red_button.dart'; // Assuming red_button.dart is in the same directory

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  int totalOrders = 0;
  int ongoingOrders = 0;
  DateTime? fromDate;
  DateTime? toDate;
  String? orderStatus;

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
        if (isFromDate) {
          fromDate = pickedDate;
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

    // Define responsive values based on screen size
    final double containerWidth = screenWidth > 600 ? 500 : screenWidth * 0.8;
    final double fontSize = screenWidth > 600 ? 16 : 14;
    final double padding = screenWidth > 600 ? 20 : 16;
    final double borderRadius = screenWidth > 600 ? 12 : 8;

    return Material(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Order Summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryCard(
                      context, 'Total Orders', totalOrders.toString()),
                  _buildSummaryCard(
                      context, 'Ongoing Orders', ongoingOrders.toString()),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              // Search Bar
              Text('Search', style: TextStyle(fontSize: fontSize)),
              SizedBox(height: screenHeight * 0.005),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter search term',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Date Range
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // From Date
                  SizedBox(
                    width: containerWidth * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From Date', style: TextStyle(fontSize: fontSize)),
                        SizedBox(height: screenHeight * 0.005),
                        InkWell(
                          onTap: () => _selectDate(context, true),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: padding/2, vertical: padding/4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  fromDate == null
                                      ? 'DD/MM/YYYY'
                                      : DateFormat('dd/MM/yyyy').format(fromDate!),
                                  style: TextStyle(fontSize: fontSize),
                                ),
                                Icon(Icons.calendar_today, size: fontSize + 4),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // To Date
                  SizedBox(
                    width: containerWidth * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('To Date', style: TextStyle(fontSize: fontSize)),
                        SizedBox(height: screenHeight * 0.005),
                        InkWell(
                          onTap: () => _selectDate(context, false),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: padding/2, vertical: padding/4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  toDate == null
                                      ? 'DD/MM/YYYY'
                                      : DateFormat('dd/MM/yyyy').format(toDate!),
                                  style: TextStyle(fontSize: fontSize),
                                ),
                                Icon(Icons.calendar_today, size: fontSize + 4),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              // Order Status
              Text('Order Status', style: TextStyle(fontSize: fontSize)),
              SizedBox(height: screenHeight * 0.005),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                value: orderStatus,
                hint: Text('Select', style: TextStyle(fontSize: fontSize)),
                items: <String>[
                  'Select',
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
                    child: Text(value, style: TextStyle(fontSize: fontSize)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    orderStatus = newValue;
                  });
                },
              ),
              SizedBox(height: screenHeight * 0.03),

              // Search Button
              RedButton(
                label: 'Search',
                onPressed: () {
                  // Implement search functionality here
                  print('Search button pressed');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String title, String value) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double containerWidth = screenWidth > 600 ? 200 : screenWidth * 0.35;
    final double fontSize = screenWidth > 600 ? 20 : 18;

    return Container(
      width: containerWidth,
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize * 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize * 0.8,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}