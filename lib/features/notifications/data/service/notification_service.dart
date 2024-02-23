import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:noti/features/notifications/data/model/notification_model.dart';
import 'package:noti/features/notifications/data/model/notification_type.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final StreamController<DateTime> _notificationSentController =
      StreamController<DateTime>.broadcast();

  static Stream<DateTime> get onNotificationSent => _notificationSentController.stream;

  static final List<NotificationModel> recurrentNotifications = [];
  static final List<NotificationModel> oneTimeNotifications = [];

  static void addOneTimeNotification(NotificationModel notification) {
    oneTimeNotifications.add(notification);
  }

  static void removeOneTimeNotification(DateTime id) {
    oneTimeNotifications.removeWhere((noti) => noti.id == id);
  }

  static void addRecurringNotification(NotificationModel notification) {
    recurrentNotifications.add(notification);
  }

  static void removeRecurringNotification(DateTime id) {
    recurrentNotifications.removeWhere((noti) => noti.id == id);
  }

  static void removeOneTimeNotificationAfterUse() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      for (var noti in oneTimeNotifications) {
        if (now.isAfter(noti.time)) {
          _notificationSentController.add(noti.id);
        }
      }
    });
  }

  static void showRecurrentNotifications() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      for (var noti in recurrentNotifications) {
        final Duration difference = now.difference(noti.time);
        final differenceInSeconds = difference.inSeconds;
        if (differenceInSeconds >= 60) {
          if (noti.notificationType == NotificationType.oneMinute &&
              differenceInSeconds % 60 == 0) {
            scheduleNotification(noti);
          } else if (noti.notificationType == NotificationType.threeMinutes &&
              differenceInSeconds % 180 == 0) {
            scheduleNotification(noti);
          } else if (noti.notificationType == NotificationType.fiveMinutes &&
              differenceInSeconds % 300 == 0) {
            scheduleNotification(noti);
          }
        }
      }
    });
  }

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => null);

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) => null);

    showRecurrentNotifications();
    removeOneTimeNotificationAfterUse();
  }

  static Future<void> scheduleNotification(NotificationModel notification) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Zaporozhye'));
    final time = notification.time;

    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      notification.id.toString(),
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    if (notification.notificationType == NotificationType.oneTime) {
      final tzTime = tz.TZDateTime(
        tz.local,
        time.year,
        time.month,
        time.day,
        time.hour,
        time.minute,
        time.second,
      );
      await flutterLocalNotificationsPlugin
          .zonedSchedule(
            notification.id.hashCode,
            'noti',
            notification.message,
            tzTime,
            platformChannelSpecifics,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
          )
          .whenComplete(() => addOneTimeNotification(notification));
    } else {
      await flutterLocalNotificationsPlugin.show(
        notification.id.hashCode,
        'noti',
        notification.message,
        platformChannelSpecifics,
      );
    }
  }

  static Future<void> cancelNotification(DateTime id) async {
    await flutterLocalNotificationsPlugin.cancel(id.hashCode);
  }
}
