part of 'notifications_bar_bloc.dart';

@freezed
class NotificationsBarState with _$NotificationsBarState {
  const factory NotificationsBarState.oneTime() = _OneTime;

  const factory NotificationsBarState.recurring() = _Recurring;
}
