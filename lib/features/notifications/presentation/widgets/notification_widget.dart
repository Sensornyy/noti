import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noti/core/shared_widgets/main_text_button.dart';
import 'package:noti/core/style/app_icons.dart';
import 'package:noti/core/style/app_theme.dart';
import 'package:noti/core/utils/date_util.dart';
import 'package:noti/features/notifications/data/model/notification_model.dart';
import 'package:noti/features/notifications/data/model/notification_type.dart';
import 'package:noti/features/notifications/presentation/bloc/icon_cubit/icon_cubit.dart';
import 'package:noti/features/notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import 'package:noti/features/notifications/presentation/screens/add_or_edit_notification_screen.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({required this.notification, Key? key}) : super(key: key);

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final icon = notification.icon;
    final isIcon = icon != null;
    final height = isIcon ? 174.0 : 138.0;
    final time = _getFormattedTime();
    final message = notification.message;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => IconCubit(),
            child: AddOrEditNotificationScreen(
              notificationType: notification.notificationType,
              isEdit: true,
              notification: notification,
            ),
          ),
        ),
      ),
      child: Container(
        constraints: BoxConstraints(minHeight: height),
        width: double.infinity,
        margin: const EdgeInsets.only(
          left: 16,
          top: 16,
          right: 16,
        ),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.buttonActive),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: GestureDetector(
                  onTap: () => BlocProvider.of<NotificationsBloc>(context).add(
                    NotificationsEvent.removeNotification(notification.id),
                  ),
                  child: const Icon(
                    AppIcons.delete,
                    color: AppTheme.errorColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: isIcon ? 10 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  if (isIcon)
                    Container(
                      height: 32,
                      width: 32,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.iconBackground),
                          color: notification.backgroundIconColor),
                      child: Icon(
                        icon,
                        color: AppTheme.buttonActive,
                      ),
                    ),
                  Row(
                    children: [
                      const Text(
                        'Time: ',
                        style: AppTheme.greyTextStyle,
                      ),
                      Text(
                        time,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Message: ',
                          style: AppTheme.greyTextStyle,
                        ),
                        TextSpan(
                          text: message,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainTextButton(onPressed: () {}, text: 'Select trigger 1'),
                      MainTextButton(onPressed: () {}, text: 'Select trigger 2'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedTime() {
    switch (notification.notificationType) {
      case NotificationType.oneMinute:
        return '1 Minute';
      case NotificationType.threeMinutes:
        return '3 Minutes';
      case NotificationType.fiveMinutes:
        return '5 Minutes';
      case NotificationType.oneTime:
        return DateUtil.toFormattedStringFromDateTime(notification.time!);
    }
  }
}
