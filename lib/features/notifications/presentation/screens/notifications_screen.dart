import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noti/core/shared_widgets/loading_indicator.dart';
import 'package:noti/core/style/app_icons.dart';
import 'package:noti/core/style/app_theme.dart';
import 'package:noti/features/notifications/data/model/notification_model.dart';
import 'package:noti/features/notifications/data/model/notification_type.dart';
import 'package:noti/features/notifications/presentation/bloc/icon_cubit/icon_cubit.dart';
import 'package:noti/features/notifications/presentation/bloc/notifications_bar_bloc/notifications_bar_bloc.dart';
import 'package:noti/features/notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import 'package:noti/features/notifications/presentation/screens/add_or_edit_notification_screen.dart';
import 'package:noti/features/notifications/presentation/widgets/add_notifications_button.dart';
import 'package:noti/features/notifications/presentation/widgets/notifications_app_bar.dart';
import 'package:noti/features/notifications/presentation/widgets/notifications_list_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationsBloc = BlocProvider.of<NotificationsBloc>(context);

    return SafeArea(
      child: Scaffold(
        appBar: const NotificationsAppBar(),
        body: BlocBuilder<NotificationsBarBloc, NotificationsBarState>(
          builder: (context, state) {
            return state.when(
                oneTime: () =>
                    BlocBuilder<NotificationsBloc, NotificationsState>(
                      builder: (context, state) {
                        notificationsBloc.add(
                            const NotificationsEvent.getNotifications(NotificationType.oneTime));
                        return state.when(
                          loading: () => const LoadingIndicator(),
                          loaded: (list) =>
                              Stack(
                                children: [
                                  NotificationsListWidget(
                                    notificationsList: list,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: AppTheme.elevatedButtonPadding),
                                      child: AddNotificationsButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                    create: (context) => IconCubit(),
                                                    child: AddOrEditNotificationScreen(
                                                      notificationType: NotificationType.oneTime,
                                                    ),
                                                  ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        );
                      },
                    ),
                recurring: () => const Stack());
          },
        ),
      ),
    );
  }
}
