import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../common/edit_textbox.dart';
import '../common/edit_textbox2.dart';
import 'items_dropdown.dart';
import '../common/red_button.dart';
import '../common/ship_bill.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'payment_failed.dart';
import '../common/congratulations.dart';
class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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
    _razorpay.clear(); // Clear all event listeners
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle successful payment
    print("Payment Successful: ${response.paymentId}");

    // Navigate to the CongratulationsScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CongratulationsScreen(),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print("Payment Failed: ${response.code} | ${response.message}");

    // Show the PaymentFailedDialog instead of a SnackBar
    PaymentFailedDialog.show(context: context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection
    print("External Wallet Selected: ${response.walletName}");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('External Wallet Selected')),
    );
  }

  void _openRazorpayCheckout() {
    var options = {
      'key': 'rzp_test_x7twCUt5gfsSV8', // Replace with your Razorpay API key
      'amount': (calculateGrandTotal() * 100).toInt(), // Amount in paise
      'name': 'Semikart',
      'description': 'Order Payment',
      'prefill': {
        'contact': '1234567890', // Replace with user's contact number
        'email': 'user@example.com', // Replace with user's email
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

  bool isChecked = false;
  // Billing Address Fields
  String? name;
  String? pincode;
  String? address1;
  String? address2;
  String? landmark;
  String? city;
  String? state;
  String? phone;
  String? company;
  String? gstn;
  
  // Shipping Address Fields
  String? shippingName;
  String? shippingPincode;
  String? shippingAddress1;
  String? shippingAddress2;
  String? shippingLandmark;
  String? shippingCity;
  String? shippingState;
  String? shippingPhone;
  String? shippingCompany;
  String? shippingGstn;

  final GlobalKey _editTextBox2Key = GlobalKey();

  final List<Map<String, dynamic>> items = [
    {
      'serialNo': 1,
      'mfrPartNumber': 'X22223201',
      'manufacturer': 'E-T-A',
      'basicUnitPrice': 2581.32,
      'quantity': 5,
      'finalUnitPrice': 2581.32,
    },
    {
      'serialNo': 2,
      'mfrPartNumber': 'X22223901',
      'manufacturer': 'E-T-A',
      'basicUnitPrice': 3681.32,
      'quantity': 5,
      'finalUnitPrice': 3681.32,
    },
  ];

  double calculateGrandTotal() {
    double total = 1;
    // for (var item in items) {
    //   total += (item['finalUnitPrice'] * item['quantity'] * 1.18) + 250;
    // }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    // Removed Scaffold widget
    return SingleChildScrollView( 
      child: Padding(
        padding: const EdgeInsets.only(
  // top: 6.0,
  bottom: 16.0,
  left: 16.0,
  right: 16.0,
),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Note:- Make sure you complete the billing address and shipping address to continue to payment.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFA51414),
                ),
              ),
            ),
            // const SizedBox(height: 3),
            EditTextBox(
              address1: address1,
              address2: address2,
              onEdit: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShipBillForm(
                      initialAddress1: address1,
                      initialAddress2: address2,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    name = result['name'];
                    pincode = result['pincode'];
                    address1 = result['address1'];
                    address2 = result['address2'];
                    landmark = result['landmark'];
                    city = result['city'];
                    state = result['state'];
                    phone = result['phone'];
                    company = result['company'];
                    gstn = result['gstn'];
                  });
                }
              },
            ),
            const SizedBox(height: 5),
            CheckboxListTile(
              value: isChecked,
              onChanged: (bool? value) async {
                if (value == true) {
                  // Check if all mandatory billing fields are filled
                  if (name == null || name!.isEmpty ||
                      pincode == null || pincode!.isEmpty ||
                      address1 == null || address1!.isEmpty ||
                      city == null || city!.isEmpty ||
                      state == null || state!.isEmpty ||
                      phone == null || phone!.isEmpty) {
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    backgroundColor: Colors.white,
    title: const Text('Missing Information'),
    content: const Text('Please fill all mandatory billing address fields'),
    actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text(
        'OK',
        style: TextStyle(color: Color(0xFFA51414)),
      ),
    ),
    ],
  ),
);
                    return;
                  }

                  // Copy all billing fields to shipping
                  setState(() {
                    isChecked = true;
                    shippingName = name;
                    shippingPincode = pincode;
                    shippingAddress1 = address1;
                    shippingAddress2 = address2;
                    shippingLandmark = landmark;
                    shippingCity = city;
                    shippingState = state;
                    shippingPhone = phone;
                    shippingCompany = company;
                    shippingGstn = gstn;
                  });

                  // Call setSimpleRadioButton on EditTextBox2
                  (_editTextBox2Key.currentState as dynamic)?.setSimpleRadioButton(
                    true,
                    '${address1 ?? ''}${address2 != null && address2!.isNotEmpty ? ', $address2' : ''}',
                  );
                } else {
                  // Clear all shipping address fields when unchecked
                  setState(() {
                    isChecked = false;
                    shippingName = null;
                    shippingPincode = null;
                    shippingAddress1 = null;
                    shippingAddress2 = null;
                    shippingLandmark = null;
                    shippingCity = null;
                    shippingState = null;
                    shippingPhone = null;
                    shippingCompany = null;
                    shippingGstn = null;
                  });

                  // Call setSimpleRadioButton to hide
                  (_editTextBox2Key.currentState as dynamic)?.setSimpleRadioButton(false, '');
                }
              },
              title: const Text(
                "Billing Address same as shipping address",
                style: TextStyle(fontSize: 14),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Color(0xFFA51414),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.only(bottom: 10), // Add 16px bottom padding
              child: EditTextBox2(
                key: _editTextBox2Key,
                title: 'Shipping Address',
                address1: shippingAddress1,
                address2: shippingAddress2,
                onEdit: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShipBillForm(
                        initialAddress1: shippingAddress1,
                        initialAddress2: shippingAddress2,
                      ),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      shippingName = result['name'];
                      shippingPincode = result['pincode'];
                      shippingAddress1 = result['address1'];
                      shippingAddress2 = result['address2'];
                      shippingLandmark = result['landmark'];
                      shippingCity = result['city'];
                      shippingState = result['state'];
                      shippingPhone = result['phone'];
                      shippingCompany = result['company'];
                      shippingGstn = result['gstn'];
                      if (isChecked) {
                        name = shippingName;
                        pincode = shippingPincode;
                        address1 = shippingAddress1;
                        address2 = shippingAddress2;
                        landmark = shippingLandmark;
                        city = shippingCity;
                        state = shippingState;
                        phone = shippingPhone;
                        company = shippingCompany;
                        gstn = shippingGstn;
                      }
                    });
                  }
                },
              ),
            ),
           
            // My Items Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
  top: 2.0,
  bottom: 8.0,
  left: 8.0,
  right: 8.0,
),
              margin: const EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Items',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('cart');
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Color(0xFFA51414),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  // const SizedBox(height: 3),
                  ...items.map((item) => Column(
                    children: [
                      ItemDropdownCard(
                        serialNo: item['serialNo'],
                        mfrPartNumber: item['mfrPartNumber'],
                        manufacturer: item['manufacturer'],
                        basicUnitPrice: item['basicUnitPrice'],
                        quantity: item['quantity'],
                        finalUnitPrice: item['finalUnitPrice'],
                      ),
                      // const SizedBox(height: 2),
                    ],
                  )).toList(),
                  const SizedBox(height: 6),
                  // Grand Total Row
                  Padding(
                    padding: const EdgeInsets.only(top: 0.1),
                    child: Row(
                      children: [
                        const Text(
                          'Grand Total   ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${calculateGrandTotal().toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA51414),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Razorpay Container
            Container(
             padding: const EdgeInsets.only(
  top: 8.0,
  bottom: 8.0,
  left: 8.0,
  right: 8.0,
),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Default Payment Option",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.radio_button_checked, color: Color(0xFFA51414)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Razorpay gateway supports the following payment modes: All Credit Cards, All Debit Cards, NetBanking, Wallet, UPI/QR, EMI, Paylater",
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Terms & Conditions Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(top: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Terms & Conditions",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "1. We hereby declare that, the parts procured from Aqtronics/SemiKart against our PO number is not sold to any of the restricted entity by US or UK and also not used in any of the products/applications such as weapon of mass destruction/aerospace or defence systems restricted by US & UK. Furthermore these parts are not to be sold to any such entities within India. In doing so, we are aware a flag will be raised to the respective supplier and all business proceedings will be cancelled.",
                            style: TextStyle(fontSize: 12, height: 1.6),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "2. Order delivery timelines may differ when procured from multiple suppliers.",
                            style: TextStyle(fontSize: 12, height: 1.6),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "3. Standard lead time will be 2-3 weeks for stock parts after receiving of PO.",
                            style: TextStyle(fontSize: 12, height: 1.6),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            RedButton(
              label: 'Continue to payment',
              onPressed: () {
                // Removed incomplete address validation and popup
                // Proceed directly with existing payment confirmation dialog
                showDialog(
                  context: context,
                  builder: (context) => PaymentConfirmationDialog(
                    amount: calculateGrandTotal(),
                    onConfirm: () {
                      Navigator.pop(context); // Close the dialog
                      _openRazorpayCheckout(); // Trigger Razorpay payment
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentConfirmationDialog extends StatelessWidget {
  final double amount;
  final VoidCallback onConfirm;

  const PaymentConfirmationDialog({
    super.key,
    required this.amount,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Confirm Payment',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA51414),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '₹${amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Total amount to be paid',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Transaction Id: T2025040942440',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Note: Please don\'t refresh the page while your transaction is in progress. '
                'If you click on back button the payment for the current transaction id will be pending. '
                'You can complete the payment within 24 hours using the "Make Payment" option in Order Dashboard (Order History).',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text(
                            'Cancel Payment',
                            
                            
                            style: TextStyle(color: Color(0xFFA51414), fontSize: 14),
                          ),
                          content: Text(
                            'Are you sure you want to cancel this order? '
                            'If you wish to complete the payment later you can do this '
                            'from "Make Payment" option in order dashboard.',
                            style: TextStyle(fontSize: 9),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFFA51414),
                              ),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close confirmation
                                Navigator.pop(context); // Close payment dialog
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFFA51414),
                              ),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: const BorderSide(color: Color(0xFFA51414)),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFFA51414),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA51414),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
