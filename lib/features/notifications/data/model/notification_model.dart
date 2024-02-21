import 'package:flutter/material.dart';
import 'package:noti/features/notifications/data/model/notification_type.dart';

class NotificationModel {
  NotificationModel({
    required this.notificationType,
    required this.message,
    required this.time,
    required this.backgroundIconColor,
    required this.icon,
  });

  final DateTime id = DateTime.now();
  final NotificationType notificationType;
  String message;
  DateTime time;
  Color? backgroundIconColor;
  IconData? icon;

  NotificationModel copyWith({
    String? message,
    DateTime? time,
    Color? backgroundIconColor,
    IconData? icon,
  }) {
    return NotificationModel(
      notificationType: notificationType,
      message: message ?? this.message,
      time: time ?? this.time,
      backgroundIconColor: backgroundIconColor ?? this.backgroundIconColor,
      icon: icon ?? this.icon,
    );
  }
}
