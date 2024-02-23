import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noti/core/shared_widgets/loading_indicator.dart';
import 'package:noti/core/shared_widgets/main_app_bar.dart';
import 'package:noti/core/style/app_icons.dart';
import 'package:noti/core/style/app_theme.dart';
import 'package:noti/features/notifications/data/model/notification_type.dart';
import 'package:noti/features/notifications/presentation/bloc/icon_cubit/icon_cubit.dart';
import 'package:noti/features/notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import 'package:noti/features/notifications/presentation/screens/add_or_edit_notification_screen.dart';
import 'package:noti/features/notifications/presentation/widgets/add_notifications_button.dart';
import 'package:noti/features/notifications/presentation/widgets/notifications_list_widget.dart';

class RecurringScreen extends StatelessWidget {
  const RecurringScreen({required this.notificationType, Key? key}) : super(key: key);

  final NotificationType notificationType;

  static const double _padding = 15.0;

  @override
  Widget build(BuildContext context) {
    final title = _getTitle(notificationType);

    return Scaffold(
      appBar: MainAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: _padding),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(AppIcons.arrowBack),
          ),
        ),
        title: title,
      ),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          BlocProvider.of<NotificationsBloc>(context).add(
            NotificationsEvent.getNotifications(notificationType),
          );
          return state.when(
            loading: () => const LoadingIndicator(),
            loaded: (list) => Stack(
              children: [
                NotificationsListWidget(
                  notificationsList: list,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppTheme.elevatedButtonPadding),
                    child: AddNotificationsButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => IconCubit(),
                              child: AddOrEditNotificationScreen(
                                notificationType: notificationType,
                                isRecurring: true,
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
    );
  }

  String _getTitle(NotificationType notificationType) {
    switch (notificationType) {
      case NotificationType.oneMinute:
        return '1 Minute';
      case NotificationType.threeMinutes:
        return '3 Minutes';
      case NotificationType.fiveMinutes:
        return '5 Minutes';
      default:
        return '';
    }
  }
}
