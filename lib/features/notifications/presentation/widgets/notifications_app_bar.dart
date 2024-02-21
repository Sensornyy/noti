import 'package:flutter/material.dart';
import 'package:noti/core/shared_widgets/main_app_bar.dart';
import 'package:noti/features/notifications/presentation/widgets/notifications_bar.dart';

class NotificationsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NotificationsAppBar({Key? key}) : super(key: key);

  static const double _height = 140.0;
  static const double _padding = 20.0;
  static const String _title = 'Notifications';

  @override
  Widget build(BuildContext context) {
    return const MainAppBar(
      title: _title,
      toolbarHeight: _height,
      child: Padding(
        padding: EdgeInsets.only(top: _padding),
        child: NotificationsBar(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_height);
}
