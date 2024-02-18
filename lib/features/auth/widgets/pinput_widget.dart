import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:noti/core/style/app_theme.dart';
import 'package:noti/features/auth/bloc/auth_bloc.dart';

class PinputWidget extends StatefulWidget {
  const PinputWidget({required this.controller, Key? key}) : super(key: key);

  final TextEditingController controller;

  @override
  State<PinputWidget> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputWidget> {
  static const double width = 44.0;
  static const double height = 48.0;
  static const double borderRadius = 8.0;
  static const double separatorPadding = 12.0;
  static const double separatorWidthOrRadius = 2.0;
  static const double separatorHeight = 24.0;
  static const int separatorIndex = 1;
  static const String separator = ':';

  final pinTheme = PinTheme(
    width: width,
    height: height,
    textStyle: AppTheme.pinputTextStyle,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: AppTheme.pinputBorder),
    ),
  );

  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Pinput(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onTapOutside: (_) => focusNode.unfocus(),
          onChanged: (pin) => authBloc.add(AuthEvent.toggle(pin)),
          controller: widget.controller,
          focusNode: focusNode,
          defaultPinTheme: pinTheme,
          separatorBuilder: (index) => index == separatorIndex
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: separatorPadding),
                  child: Text(
                    separator,
                    style: AppTheme.pinputSeparatorStyle,
                  ),
                )
              : const SizedBox(width: separatorPadding),
          cursor: Container(
            decoration: BoxDecoration(
              color: AppTheme.textColor,
              borderRadius: BorderRadius.circular(separatorWidthOrRadius),
            ),
            width: separatorWidthOrRadius,
            height: separatorHeight,
          ),
          focusedPinTheme: pinTheme.copyWith(
            decoration: pinTheme.decoration!.copyWith(
              border: Border.all(color: AppTheme.pinputBorderFocused),
            ),
          ),
        ),
      ],
    );
  }
}
