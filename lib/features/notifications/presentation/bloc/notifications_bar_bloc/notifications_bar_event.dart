part of 'notifications_bar_bloc.dart';

@freezed
class NotificationsBarEvent with _$NotificationsBarEvent {
  const factory NotificationsBarEvent.setOneTime() = _SetOneTime;

  const factory NotificationsBarEvent.setRecurring() = _SetRecurring;
}
