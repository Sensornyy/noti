import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noti/core/style/app_icons.dart';

class NotificationsListWidget extends StatelessWidget {
  const NotificationsListWidget({
    required this.notificationsList,
    Key? key,
  }) : super(key: key);

  final List notificationsList;

  static const double _iconSize = 75.0;
  static const String _emptyListTip = 'No notifications. Press to add new notifications';

  @override
  Widget build(BuildContext context) {
    return notificationsList.isEmpty
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  AppIcons.addCircle,
                  size: _iconSize,
                ),
                Text(_emptyListTip)
              ],
            ),
          )
        : ListView.builder(
            itemCount: notificationsList.length,
            itemBuilder: (context, index) {
              return Text('$index');
            },
          );
  }
}
