import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noti/core/style/app_theme.dart';
import 'package:noti/features/auth/bloc/auth_bloc.dart';
import 'package:noti/features/auth/screens/auth_screen.dart';
import 'package:noti/features/notifications/data/service/notification_service.dart';
import 'package:noti/features/notifications/presentation/bloc/notifications_bar_bloc/notifications_bar_bloc.dart';
import 'package:noti/features/notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import 'package:noti/features/notifications/presentation/screens/notifications_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(const NotiApp());
}

class NotiApp extends StatelessWidget {
  const NotiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<NotificationsBarBloc>(
          create: (context) => NotificationsBarBloc(),
        ),
        BlocProvider<NotificationsBloc>(
          create: (context) => NotificationsBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: AuthScreen(),
      ),
    );
  }
}
