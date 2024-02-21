import 'package:flutter/material.dart';
import 'package:noti/core/style/app_icons.dart';
import 'package:noti/core/style/app_theme.dart';

class ErrorBarWidget extends StatelessWidget {
  const ErrorBarWidget({Key? key}) : super(key: key);

  static const double _iconLeftPadding = 12.0;
  static const double _iconRightPadding = 6.0;
  static const String _errorText = 'The time is wrong. Try again.';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.barHeight,
      width: double.infinity,
      color: AppTheme.barBackground,
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: _iconLeftPadding, right: _iconRightPadding),
            child: Icon(
              AppIcons.error,
              color: AppTheme.errorColor,
            ),
          ),
          Text(
            _errorText,
            style: AppTheme.errorTextStyle,
          )
        ],
      ),
    );
  }
}
