part of 'icon_cubit.dart';

@freezed
class IconState with _$IconState {
  const factory IconState.initial() = _Initial;

  const factory IconState.changed({
    Color? backgroundIconColor,
    IconData? icon,
  }) = _Changed;
}
