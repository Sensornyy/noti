import 'package:flutter/material.dart';
import 'package:noti/core/style/app_icons.dart';
import 'package:noti/core/style/app_theme.dart';

class AddNotificationsButton extends StatelessWidget {
  const AddNotificationsButton({required this.onPressed, Key? key}) : super(key: key);

  final void Function()? onPressed;

  static const double _padding = 15.0;
  static const double _borderRadius = 8.0;
  static const String _label = 'Add new notification';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _padding),
      child: SizedBox(
        height: AppTheme.barHeight,
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(AppIcons.addCircle),
          label: const Text(_label),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
          ),
        ),
      ),
    );
  }
}
