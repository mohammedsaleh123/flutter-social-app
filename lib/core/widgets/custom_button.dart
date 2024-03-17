import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.child,
      required this.color,
      required this.radius,
      required this.minWidth});
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final double radius;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
