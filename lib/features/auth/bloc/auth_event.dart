part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.logIn(String pin) = _LogIn;

  const factory AuthEvent.toggle(String pin) = _Toggle;
}
