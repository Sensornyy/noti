import 'package:flutter/material.dart';
import 'package:noti/features/notifications/presentation/widgets/notification_widget.dart';

class NotificationsListWidget extends StatelessWidget {
  const NotificationsListWidget({
    required this.notificationsList,
    Key? key,
  }) : super(key: key);

  final List notificationsList;

  static const double _padding = 100.0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notificationsList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: index == notificationsList.length - 1
              ? const EdgeInsets.only(bottom: _padding)
              : EdgeInsets.zero,
          child: NotificationWidget(notification: notificationsList[index]),
        );
      },
      physics: const BouncingScrollPhysics(),
    );
  }
}
