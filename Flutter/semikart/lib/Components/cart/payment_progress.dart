import 'package:flutter/material.dart';
import 'package:Semikart/Components/common/red_button.dart';

class PaymentProgress {
  static Future<void> show({
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Payment is in progress',
                  style: TextStyle(
                    color: Color(0xFFA51414),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'Please, wait a few moments',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                // RedButton(
                //   label: 'OK',
                //   onPressed: () => Navigator.of(context).pop(),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
