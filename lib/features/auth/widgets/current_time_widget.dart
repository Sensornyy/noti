import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentTimeWidget extends StatefulWidget {
  const CurrentTimeWidget({Key? key}) : super(key: key);

  @override
  State<CurrentTimeWidget> createState() => _CurrentTimeWidgetState();
}

class _CurrentTimeWidgetState extends State<CurrentTimeWidget> {
  static const String dateFormat = 'HH:mm';
  static const int duration = 1;

  late DateTime currentTime;
  late String formattedTime;
  late int previousMinute;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    currentTime = DateTime.now();
    previousMinute = currentTime.minute;
    formattedTime = DateFormat(dateFormat).format(currentTime);
    timer = Timer.periodic(const Duration(seconds: duration), (timer) {
      currentTime = DateTime.now();
      if (currentTime.minute != previousMinute) {
        setState(() {
          previousMinute = currentTime.minute;
          formattedTime = DateFormat(dateFormat).format(currentTime);
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedTime,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
