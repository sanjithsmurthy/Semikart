
import 'package:flutter/material.dart';

class WhiteScreen extends StatelessWidget {
  final Widget child;

  const WhiteScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 412,
      height: 917,
      decoration: BoxDecoration(
        color: Colors.white,
        
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: child,
      ),
    );
  }
}