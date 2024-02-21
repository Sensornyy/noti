part of 'notifications_bloc.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState.loading() = _Loading;

  const factory NotificationsState.loaded(List<NotificationModel> list) = _Loaded;
}
