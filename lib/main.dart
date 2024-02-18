import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noti/core/style/app_theme.dart';
import 'package:noti/features/auth/screens/auth_screen.dart';

import 'features/auth/bloc/auth_bloc.dart';

void main() => runApp(const NotiApp());

class NotiApp extends StatelessWidget {
  const NotiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: AuthScreen(),
      ),
    );
  }
}
