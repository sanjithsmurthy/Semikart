import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final Widget child;
  final VoidCallback? onClose;

  const CustomPopup({
    Key? key,
    required this.child,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),  // Screen dimming overlay
      child: Center(
        child: Container(
          width: 390,
          height: 225,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: Color(0xFF707070),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: child,
              ),
              if (onClose != null)
                Positioned(
                  right: 16,
                  top: 16,
                  child: InkWell(
                    onTap: onClose,
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: Color(0xFF707070),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}