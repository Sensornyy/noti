import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noti/core/utils/date_util.dart';

part 'auth_event.dart';

part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.disabled()) {
    const duration = 750;
    const pinLength = 4;

    on<AuthEvent>((event, emit) async {
      await event.when(logIn: (pin) async {
        emit(const AuthState.loading());

        String formattedTime = DateUtil.toStringFromDateTimeNow();

        await Future.delayed(const Duration(milliseconds: duration));

        if (formattedTime == pin) {
          emit(const AuthState.success());
        } else {
          emit(const AuthState.error());
        }
      }, toggle: (pin) {
        if (pin.length < pinLength) {
          emit(const AuthState.disabled());
        } else {
          emit(const AuthState.enabled());
        }
      });
    });
  }
}
