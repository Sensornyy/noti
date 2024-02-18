part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = _Loading;

  const factory AuthState.disabled() = _Disabled;

  const factory AuthState.enabled() = _Enabled;

  const factory AuthState.error() = _Error;

  const factory AuthState.success() = _Success;
}
