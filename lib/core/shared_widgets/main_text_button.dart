import 'package:flutter/material.dart';

class MainTextButton extends StatelessWidget {
  const MainTextButton({
    required this.onPressed,
    required this.text,
    Key? key,
  }) : super(key: key);

  final Function()? onPressed;
  final String text;

  static const double _height = 40.0;
  static const double _width = 158.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
