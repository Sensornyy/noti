import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noti/core/style/app_icons.dart';
import 'package:noti/core/style/app_theme.dart';
import 'package:noti/features/notifications/presentation/bloc/notifications_bar_bloc/notifications_bar_bloc.dart';
import 'package:noti/features/notifications/presentation/widgets/notifications_bar_item.dart';

class NotificationsBar extends StatelessWidget {
  const NotificationsBar({Key? key}) : super(key: key);

  static const double _barRadius = 8.0;
  static const double _barWidth = 361.0;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NotificationsBarBloc>(context);

    return Container(
      width: _barWidth,
      height: AppTheme.barHeight,
      decoration: BoxDecoration(
        color: AppTheme.barBackground,
        borderRadius: BorderRadius.circular(_barRadius),
      ),
      child: BlocBuilder<NotificationsBarBloc, NotificationsBarState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => bloc.add(
                  const NotificationsBarEvent.setOneTime(),
                ),
                child: NotificationsBarItem(
                  icon: AppIcons.timer,
                  text: 'One-time',
                  isSelected: state.when(
                    oneTime: () => true,
                    recurring: () => false,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => bloc.add(
                  const NotificationsBarEvent.setRecurring(),
                ),
                child: NotificationsBarItem(
                  icon: AppIcons.history,
                  text: 'Recurring',
                  isSelected: state.when(
                    oneTime: () => false,
                    recurring: () => true,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
