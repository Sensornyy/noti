import 'package:flutter/material.dart';
import 'package:noti/core/style/app_icons.dart';
import 'package:noti/core/style/app_theme.dart';

class RecurringContainer extends StatelessWidget {
  const RecurringContainer({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 56.0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.iconBorder,
          border: Border.all(
            color: AppTheme.pinputSeparator,
            width: 0.2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Icon(
              AppIcons.arrowForward,
              color: AppTheme.buttonActive,
            )
          ],
        ),
      ),
    );
  }
}
