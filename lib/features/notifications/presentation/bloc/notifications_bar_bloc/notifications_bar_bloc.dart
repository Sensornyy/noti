import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_bar_event.dart';

part 'notifications_bar_state.dart';

part 'notifications_bar_bloc.freezed.dart';

class NotificationsBarBloc extends Bloc<NotificationsBarEvent, NotificationsBarState> {
  NotificationsBarBloc() : super(const NotificationsBarState.oneTime()) {
    on<NotificationsBarEvent>((event, emit) {
      event.when(
        setOneTime: () => emit(
          const NotificationsBarState.oneTime(),
        ),
        setRecurring: () => emit(
          const NotificationsBarState.recurring(),
        ),
      );
    });
  }
}
