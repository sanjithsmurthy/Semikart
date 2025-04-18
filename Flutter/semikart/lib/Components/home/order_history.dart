import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/red_button.dart';
import 'order_history_item.dart';

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

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050), // Updated lastDate
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

    final double containerWidth = screenWidth > 600 ? 500 : screenWidth * 0.8;
    final double fontSize = screenWidth > 600 ? 16 : 14;
    final double padding = screenWidth > 600 ? 20 : 16;
    final double borderRadius = screenWidth > 600 ? 12 : 8;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('From Date', style: TextStyle(fontSize: fontSize)),
                      SizedBox(height: screenHeight * 0.005),
                      SizedBox(
                        width: containerWidth / 2,
                        child: InkWell(
                          onTap: () => _selectDate(context, true),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              hintText: 'DD/MM/YYYY',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                              ),
                            ),
                            child: Text(
                              fromDate != null
                                  ? DateFormat('dd/MM/yyyy').format(fromDate!)
                                  : 'DD/MM/YYYY',
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('To Date', style: TextStyle(fontSize: fontSize)),
                      SizedBox(height: screenHeight * 0.005),
                      SizedBox(
                        width: containerWidth / 2,
                        child: InkWell(
                          onTap: () => _selectDate(context, false),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              hintText: 'DD/MM/YYYY',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                              ),
                            ),
                            child: Text(
                              toDate != null
                                  ? DateFormat('dd/MM/yyyy').format(toDate!)
                                  : 'DD/MM/YYYY',
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
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
                items: const <String>[
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
              RedButton(
                label: 'Search',
                isWhiteButton: true, // Set the isWhite parameter to true
                onPressed: () {
                  // Implement search functionality here
                  print('Search button pressed');
                },
              ),
              SizedBox(height: screenHeight * 0.01),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.006, // 2px top padding
                  bottom: screenHeight * 0.001, // 1px bottom padding
                ),
                child: Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: fontSize * 1.4,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.001), // 1px space between "Orders" and the first container
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
              SizedBox(height: screenHeight * 0.001), // 1px space between containers
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