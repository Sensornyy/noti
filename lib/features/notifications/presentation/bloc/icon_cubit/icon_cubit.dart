import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'icon_state.dart';

part 'icon_cubit.freezed.dart';

class IconCubit extends Cubit<IconState> {
  IconCubit() : super(const IconState.initial());

  Color? previousBackgroundColor;
  IconData? previousIcon;
  int? previousColorIndex;
  int? previousIconIndex;

  void changeIcon({
    Color? backgroundIconColor,
    IconData? icon,
    int? colorIndex,
    int? iconIndex,
  }) {
    emit(
      IconState.changed(
        backgroundIconColor: backgroundIconColor ?? previousBackgroundColor,
        icon: icon ?? previousIcon,
      ),
    );

    previousBackgroundColor = backgroundIconColor ?? previousBackgroundColor;
    previousIcon = icon ?? previousIcon;
    previousColorIndex = colorIndex ?? previousColorIndex;
    previousIconIndex = iconIndex ?? previousIconIndex;
  }
}
