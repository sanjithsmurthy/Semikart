import 'package:flutter/material.dart';

class OrderHistoryItem extends StatelessWidget {
  final String orderId;
  final String orderStatus;
  final String transactionId;
  final String orderDate;
  final String poDate;
  final String customerPo;
  final String paymentStatus;
  final String amount;
  final Function onMakePayment;
  // New parameters for text sizes
  final double titleFontSize;
  final double bodyFontSize;
  final double labelFontSize;

  const OrderHistoryItem({
    Key? key,
    required this.orderId,
    required this.orderStatus,
    required this.transactionId,
    required this.orderDate,
    required this.poDate,
    required this.customerPo,
    required this.paymentStatus,
    required this.amount,
    required this.onMakePayment,
    this.titleFontSize = 14.0,  // Default size
    this.bodyFontSize = 12.0,   // Default size
    this.labelFontSize = 11.0,  // Default size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double fontSize = screenWidth > 600 ? 16 : 14;
    final double padding = screenWidth > 600 ? 11 : 9; // Reduced by ~25%
    final double borderRadius = screenWidth > 600 ? 12 : 8;

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.004),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderId,
            style: TextStyle(
              fontSize: titleFontSize * 1,
              fontWeight: FontWeight.bold,
              color: orderId == "A51414" ? Colors.red : Colors.black,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            orderStatus,
            style: TextStyle(
              fontSize: titleFontSize*0.7,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOrderDetail('Transaction #', transactionId, titleFontSize*0.8),
              _buildOrderDetail('Order date', orderDate, titleFontSize*0.8),
            ],
          ),
          SizedBox(height: screenHeight * 0.006),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOrderDetail('PO date', poDate, titleFontSize*0.8),
              _buildOrderDetail('Customer PO', customerPo, titleFontSize*0.8),
            ],
          ),
          SizedBox(height: screenHeight * 0.005),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildOrderDetail('Payment Status', paymentStatus, titleFontSize*0.9),
              _buildOrderDetail('Amount', amount, titleFontSize*0.9),
              ElevatedButton(
                onPressed: () {
                  _showPaymentPopup(context, transactionId, amount);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 175, 32, 21),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 15, // Even more reduced padding
                    vertical: 7,    // Even more reduced padding
                  ),
                  minimumSize: Size(10, 10), // Allow the button to be smaller
                ),
                child: Text(
                  'Make Payment',
                  style: TextStyle(
                    fontSize: titleFontSize*0.7, // Slightly smaller text
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.005),
        ],
      ),
    );
  }

  Widget _buildOrderDetail(String title, String value, double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: labelFontSize,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showPaymentPopup(BuildContext context, String transactionId, String amount) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth > 600 ? 16 : 14;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Changed background to white
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.all(16),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Default Payment Option',
                  style: TextStyle(
                    fontSize: fontSize * 1.2 - 2, // Reduced by 2px
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Razorpay gateway supports the following payment modes: All Credit Cards, All Debit Cards, NetBanking, Wallet, UPI/QR, EMI, Paylater',
                  style: TextStyle(fontSize: fontSize - 2), // Reduced by 2px
                ),
                SizedBox(height: 16),
                _buildPopupDetail('Transaction Id:', transactionId, fontSize - 2), // Reduced by 2px
                SizedBox(height: 8),
                _buildPopupDetail('Amount:', 'Rs.$amount/-', fontSize - 2), // Reduced by 2px
                SizedBox(height: 16),
                Text(
                  'Note: Please don\'t refresh the page while your transaction is in progress. If you click on back button the payment for the current transaction id will be pending. You can complete the payment within 24 hours using the "Make Payment" option in Order Dashboard (Order History).',
                  style: TextStyle(
                    fontSize: fontSize * 0.9 - 2, // Reduced by 2px
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement payment functionality here
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 175, 32, 21),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Click here to pay',
                      style: TextStyle(
                        fontSize: fontSize - 2, // Reduced by 2px
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: fontSize - 2, // Reduced by 2px
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildPopupDetail(String title, String value, double fontSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ],
    );
  }
}