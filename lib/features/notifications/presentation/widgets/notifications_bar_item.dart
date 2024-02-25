import 'package:flutter/material.dart';
import 'package:noti/core/style/app_theme.dart';

class NotificationsBarItem extends StatelessWidget {
  const NotificationsBarItem({
    required this.icon,
    required this.text,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final bool isSelected;

  static const double _padding = 4.0;
  static const double _containerMinWidth = 152.0;
  static const double _containerMaxWidth = 175.0;
  static const double _containerRadius = 6.0;
  static const double _containerHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    final containerColor = isSelected ? AppTheme.buttonActive : AppTheme.barBackground;
    final textOrIconColor = isSelected ? AppTheme.whiteTextColor : AppTheme.textColor;
    final sizeWidth = MediaQuery.of(context).size.width;
    final width = sizeWidth < 390 ? _containerMinWidth : _containerMaxWidth;

    return Container(
      width: width,
      height: _containerHeight,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(_containerRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: textOrIconColor,
          ),
          const SizedBox(width: _padding),
          Text(
            text,
            style: TextStyle(
              color: textOrIconColor,
            ),
          ),
        ],
      ),
    );
  }
}
