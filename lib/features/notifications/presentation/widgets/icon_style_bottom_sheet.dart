import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noti/core/shared_widgets/main_button.dart';
import 'package:noti/core/style/app_colors.dart';
import 'package:noti/core/style/app_icons.dart';
import 'package:noti/core/style/app_theme.dart';
import 'package:noti/features/notifications/presentation/bloc/icon_cubit/icon_cubit.dart';
import 'package:noti/features/notifications/presentation/widgets/icon_widget.dart';

class IconStyleBottomSheet extends StatelessWidget {
  const IconStyleBottomSheet({required this.bloc, Key? key}) : super(key: key);

  final IconCubit bloc;
  final int selectedColorIndex = 0;
  final int selectedIconIndex = 0;

  static const double padding = 16.0;
  static const List<IconData> iconsList = [
    AppIcons.business,
    AppIcons.list,
    AppIcons.personCheck,
    AppIcons.notifications,
    AppIcons.error,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Container(
        height: 475,
        padding: const EdgeInsets.symmetric(vertical: padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Icon style',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          AppIcons.cancel,
                          color: AppTheme.buttonActive,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: padding),
                  const Divider(
                    color: AppColors.greyBlue,
                    thickness: 1,
                  ),
                  const SizedBox(height: padding),
                  const Text(
                    'Background colors',
                    style: AppTheme.greyMediumTextStyle,
                  ),
                  const SizedBox(height: padding),
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      itemCount: 5,
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => bloc.changeIcon(
                          backgroundIconColor: AppColors.iconColors[index],
                          colorIndex: index,
                        ),
                        child: BlocBuilder<IconCubit, IconState>(
                          builder: (context, state) {
                            return IconWidget(
                              containerSize: 70,
                              isIcon: false,
                              backgroundColor: AppColors.iconColors[index],
                              isSelected: bloc.previousColorIndex == index,
                            );
                          },
                        ),
                      ),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                  const SizedBox(height: padding),
                  const Text(
                    'Select icons',
                    style: AppTheme.greyMediumTextStyle,
                  ),
                  const SizedBox(height: padding),
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      itemCount: 5,
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => bloc.changeIcon(
                          icon: iconsList[index],
                          iconIndex: index,
                        ),
                        child: BlocBuilder<IconCubit, IconState>(
                          builder: (context, state) {
                            return IconWidget(
                              containerSize: 70,
                              icon: iconsList[index],
                              iconColor: AppTheme.buttonActive,
                              backgroundColor: AppTheme.scaffoldColor,
                              isSelected: bloc.previousIconIndex == index,
                            );
                          },
                        ),
                      ),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MainButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Save changes'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
