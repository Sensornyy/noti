import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noti/features/notifications/data/model/notification_model.dart';
import 'package:noti/features/notifications/data/model/notification_type.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

part 'notifications_bloc.freezed.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final List<NotificationModel> list = [];

  NotificationsBloc() : super(const NotificationsState.loading()) {
    on<NotificationsEvent>((event, emit) {
      event.when(
        addNotification: (notification) {
          list.add(notification);
        },
        removeNotification: (id) {
          list.removeWhere((notification) => notification.id == id);
        },
        editNotification: (
          id,
          message,
          time,
          backgroundIconColor,
          icon,
        ) {
          list.firstWhere((notification) {
            if (notification.id == id) {
              notification.copyWith(
                message: message,
                time: time,
                backgroundIconColor: backgroundIconColor,
                icon: icon,
              );
              return true;
            }
            return false;
          });
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
  }
}
