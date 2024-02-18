import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({required this.onPressed, required this.child, Key? key}) : super(key: key);

  final void Function()? onPressed;
  final Widget child;

  static const double _height = 58.0;
  static const double _borderRadius = 12.0;
  static const double _padding = 15.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _padding),
      child: SizedBox(
        height: _height,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
          ),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
