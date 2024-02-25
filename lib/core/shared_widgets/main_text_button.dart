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
  static const double _maxWidth = 158.0;
  static const double _minWidth = 140.0;

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final width = sizeWidth < 390 ? _minWidth : _maxWidth;

    return SizedBox(
      height: _height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
