part of 'notifications_bloc.dart';

@freezed
class NotificationsEvent with _$NotificationsEvent {
  const factory NotificationsEvent.addNotification(NotificationModel notification) =
      _AddNotification;

  const factory NotificationsEvent.removeNotification(DateTime id) = _RemoveNotification;

  const factory NotificationsEvent.editNotification({
    required DateTime id,
    String? newMessage,
    DateTime? time,
    Color? backgroundIconColor,
    IconData? icon,
  }) = _EditNotification;

  const factory NotificationsEvent.getNotifications(NotificationType type) = _GetNotifications;
}
