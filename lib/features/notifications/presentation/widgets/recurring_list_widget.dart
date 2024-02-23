import 'package:flutter/material.dart';
import 'package:noti/features/notifications/data/model/notification_type.dart';
import 'package:noti/features/notifications/presentation/screens/recurring_screen.dart';
import 'package:noti/features/notifications/presentation/widgets/recurring_container.dart';

class RecurringListWidget extends StatelessWidget {
  const RecurringListWidget({Key? key}) : super(key: key);

  static const String _oneMinute = '1 Minute';
  static const String _threeMinutes = '3 Minutes';
  static const String _fiveMinutes = '5 Minutes';
  static const List<String> _texts = [
    _oneMinute,
    _threeMinutes,
    _fiveMinutes,
  ];
  static const List<NotificationType> _types = [
    NotificationType.oneMinute,
    NotificationType.threeMinutes,
    NotificationType.fiveMinutes,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _texts.length,
      itemBuilder: (context, index) => RecurringContainer(
        text: _texts[index],
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecurringScreen(notificationType: _types[index]),
          ),
        ),
      ),
    );
  }
}
