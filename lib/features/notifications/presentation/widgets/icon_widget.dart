import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noti/core/style/app_icons.dart';
import 'package:noti/core/style/app_theme.dart';
import 'package:noti/features/notifications/data/model/notification_model.dart';
import 'package:noti/features/notifications/presentation/bloc/icon_cubit/icon_cubit.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    this.notification,
    this.containerSize = 80.0,
    this.iconSize = 48.0,
    this.backgroundColor,
    this.iconColor,
    this.icon,
    this.isIcon = true,
    this.isSelected = false,
    Key? key,
  }) : super(key: key);

  final NotificationModel? notification;
  final double containerSize;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData? icon;
  final bool isIcon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final isIconNotification = notification?.icon != null;

    return BlocBuilder<IconCubit, IconState>(
      builder: (context, state) {
        return Container(
          height: containerSize,
          width: containerSize,
          decoration: BoxDecoration(
            color: backgroundColor ??
                state.when(
                  initial: () => notification?.backgroundIconColor ?? AppTheme.scaffoldColor,
                  changed: (color, _) => color,
                ),
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(
                    color: AppTheme.buttonActive,
                    width: 2.5,
                  )
                : Border.all(color: AppTheme.iconBorder),
          ),
          child: isIcon
              ? Icon(
                  icon ??
                      state.when(
                        initial: () => notification?.icon ?? AppIcons.image,
                        changed: (_, icon) => icon,
                      ),
                  color: iconColor ??
                      state.when(
                        initial: () =>
                            isIconNotification ? AppTheme.buttonActive : AppTheme.iconColor,
                        changed: (_, __) => AppTheme.buttonActive,
                      ),
                  size: iconSize,
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
