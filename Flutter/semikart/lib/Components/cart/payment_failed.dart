import 'package:flutter/material.dart';
import '../common/popup.dart';
import '../common/red_button.dart';

class PaymentFailedDialog {
  static Future<void> show({
    required BuildContext context,
  }) async {
    final popupWidth = MediaQuery.of(context).size.width * 0.9;
    
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: popupWidth,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "We couldn't proceed your payment",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Please, change your payment method or try again",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RedButton(
                    label: 'Try Again',
                    width: popupWidth * 0.35,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  RedButton(
                    label: 'Change',
                    width: popupWidth * 0.35,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
