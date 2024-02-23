import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noti/features/notifications/data/model/notification_model.dart';
import 'package:noti/features/notifications/data/model/notification_type.dart';
import 'package:noti/features/notifications/data/service/notification_service.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

part 'notifications_bloc.freezed.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final List<NotificationModel> list = [];

  NotificationsBloc() : super(const NotificationsState.loading()) {
    on<NotificationsEvent>((event, emit) async {
      await event.when(
        addNotification: (notification) async {
          list.add(notification);
          if (notification.notificationType == NotificationType.oneTime) {
            await NotificationService.scheduleNotification(notification);
          } else {
            NotificationService.addRecurringNotification(notification);
          }
        },
        removeNotification: (id) async {
          list.removeWhere((notification) => notification.id == id);

          await NotificationService.cancelNotification(id);
          NotificationService.removeRecurringNotification(id);
        },
        editNotification: (
          id,
          message,
          time,
          backgroundIconColor,
          icon,
        ) async {
          await NotificationService.cancelNotification(id);
          NotificationService.removeRecurringNotification(id);
          int index = list.indexWhere((notification) => notification.id == id);
          list[index] = list[index].copyWith(
            message: message,
            time: time,
            backgroundIconColor: backgroundIconColor,
            icon: icon,
          );
          if (time != null) {
            await NotificationService.scheduleNotification(list[index]);
          } else {
            NotificationService.addRecurringNotification(list[index]);
          }
        },
        getNotifications: (type) {
          emit(const NotificationsState.loading());

          final List<NotificationModel> newList = [];

          for (var notification in list) {
            if (notification.notificationType == type) {
              newList.add(notification);
            }
          }

          emit(NotificationsState.loaded(newList));
        },
      );
    });

    NotificationService.onNotificationSent.listen((notificationId) async {
      list.removeWhere((notification) => notification.id == notificationId);
      NotificationService.removeOneTimeNotification(notificationId);
    });
  }
}
