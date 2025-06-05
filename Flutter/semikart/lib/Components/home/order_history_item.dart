import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../common/congratulations.dart';
import '../cart/payment_failed.dart';

class OrderHistoryItem extends StatefulWidget {
  final String orderId;
  final String orderStatus;
  final String transactionId;
  final String orderDate;
  final String poDate;
  final String customerPo;
  final String paymentStatus;
  final String amount;
  final Function onMakePayment;
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
    this.titleFontSize = 14.0,
    this.bodyFontSize = 12.0,
    this.labelFontSize = 11.0,
  }) : super(key: key);

  @override
  State<OrderHistoryItem> createState() => _OrderHistoryItemState();
}

class _OrderHistoryItemState extends State<OrderHistoryItem> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CongratulationsScreen(),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    PaymentFailedDialog.show(context: context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('External Wallet Selected')),
    );
  }

  void _openRazorpayCheckout() {
    var options = {
      'key': 'rzp_test_x7twCUt5gfsSV8',
      'amount': (double.tryParse(widget.amount) ?? 1) * 100, // Amount in paise
      'name': 'Semikart',
      'description': 'Order Payment',
      'prefill': {
        'contact': '1234567890',
        'email': 'user@example.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

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
            widget.orderId,
            style: TextStyle(
              fontSize: widget.titleFontSize * 1,
              fontWeight: FontWeight.bold,
              color: widget.orderId == "A51414" ? Colors.red : Colors.black,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            widget.orderStatus,
            style: TextStyle(
              fontSize: widget.titleFontSize*0.7,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOrderDetail('Transaction #', widget.transactionId, widget.titleFontSize*0.8),
              _buildOrderDetail('Order date', widget.orderDate, widget.titleFontSize*0.8),
            ],
          ),
          SizedBox(height: screenHeight * 0.006),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOrderDetail('PO date', widget.poDate, widget.titleFontSize*0.8),
              _buildOrderDetail('Customer PO', widget.customerPo, widget.titleFontSize*0.8),
            ],
          ),
          SizedBox(height: screenHeight * 0.005),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildOrderDetail('Payment Status', widget.paymentStatus, widget.titleFontSize*0.9),
              _buildOrderDetail('Amount', widget.amount, widget.titleFontSize*0.9),
              ElevatedButton(
                onPressed: () {
                  _showPaymentPopup(context, widget.transactionId, widget.amount);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 175, 32, 21),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width > 600 ? 12 : 8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 7,
                  ),
                  minimumSize: const Size(10, 10),
                ),
                child: Text(
                  'Make Payment',
                  style: TextStyle(
                    fontSize: widget.titleFontSize * 0.7,
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

  void _showPaymentPopup(BuildContext context, String transactionId, String amount) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth > 600 ? 16 : 14;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.all(16),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Default Payment Option',
                  style: TextStyle(
                    fontSize: fontSize * 1.2 - 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Razorpay gateway supports the following payment modes: All Credit Cards, All Debit Cards, NetBanking, Wallet, UPI/QR, EMI, Paylater',
                  style: TextStyle(fontSize: fontSize - 2),
                ),
                const SizedBox(height: 16),
                _buildPopupDetail('Transaction Id:', transactionId, fontSize - 2),
                const SizedBox(height: 8),
                _buildPopupDetail('Amount:', 'Rs.$amount/-', fontSize - 2),
                const SizedBox(height: 16),
                Text(
                  'Note: Please don\'t refresh the page while your transaction is in progress. If you click on back button the payment for the current transaction id will be pending. You can complete the payment within 24 hours using the "Make Payment" option in Order Dashboard (Order History).',
                  style: TextStyle(
                    fontSize: fontSize * 0.9 - 2,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _openRazorpayCheckout();
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
                        fontSize: fontSize - 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
                        fontSize: fontSize - 2,
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

  Widget _buildOrderDetail(String title, String value, double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: widget.labelFontSize,
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
        const SizedBox(width: 8),
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