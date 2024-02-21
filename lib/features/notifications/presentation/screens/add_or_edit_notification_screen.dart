import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:noti/core/shared_widgets/main_app_bar.dart';
import 'package:noti/core/shared_widgets/main_button.dart';
import 'package:noti/core/shared_widgets/main_text_button.dart';
import 'package:noti/core/shared_widgets/pinput_widget.dart';
import 'package:noti/core/style/app_icons.dart';
import 'package:noti/core/style/app_theme.dart';
import 'package:noti/core/utils/date_util.dart';
import 'package:noti/core/utils/validator_util.dart';
import 'package:noti/features/notifications/data/model/notification_model.dart';
import 'package:noti/features/notifications/data/model/notification_type.dart';
import 'package:noti/features/notifications/presentation/bloc/icon_cubit/icon_cubit.dart';
import 'package:noti/features/notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import 'package:noti/features/notifications/presentation/widgets/icon_style_bottom_sheet.dart';
import 'package:noti/features/notifications/presentation/widgets/icon_widget.dart';

class AddOrEditNotificationScreen extends StatefulWidget {
  const AddOrEditNotificationScreen({
    this.notification,
    required this.notificationType,
    this.isEdit = false,
    this.isRecurring = false,
    Key? key,
  }) : super(key: key);

  final NotificationModel? notification;
  final NotificationType notificationType;
  final bool isEdit;
  final bool isRecurring;

  @override
  State<AddOrEditNotificationScreen> createState() => _AddOrEditNotificationScreenState();
}

class _AddOrEditNotificationScreenState extends State<AddOrEditNotificationScreen> {
  static const int maxLines = 3;
  static const double borderWidth = 1.0;
  static const double padding = 15.0;
  static const double smallPadding = 8.0;
  static const double borderRadius = 8.0;
  static const String dateFormat = 'HH:mm';
  static const String appBarTitle = 'Add new notification';
  static const String appBarEditTitle = 'Edit notification';
  static const String enterMessage = 'Enter message';
  static const String messageText = 'Message';
  static const String typeTime = 'Type time';
  static const String icon = 'Icon';

  late final NotificationModel? notification;
  late final String? message;
  late final String title;
  late final String formattedTime;
  late final bool isRecurring;
  late final TextEditingController messageController;
  late final TextEditingController pinputController;
  late final GlobalKey<FormState> formKey;
  late final FocusNode messageFocusNode;

  @override
  void initState() {
    super.initState();
    notification = widget.notification;
    message = notification == null ? '' : notification!.message;
    title = widget.isEdit ? appBarEditTitle : appBarTitle;
    formattedTime = notification == null ? '' : DateFormat(dateFormat).format(notification!.time);
    isRecurring = widget.isRecurring;
    messageController = TextEditingController(text: message);
    pinputController = TextEditingController(text: formattedTime);
    formKey = GlobalKey<FormState>();
    messageFocusNode = FocusNode();
  }

  @override
  void dispose() {
    messageController.dispose();
    messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<IconCubit>(context);
    return Form(
      key: formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MainAppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: padding),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(AppIcons.arrowBack),
            ),
          ),
          title: title,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: padding,
                vertical: padding,
              ),
              child: Column(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: smallPadding),
                    child: Text(
                      messageText,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  TextFormField(
                    focusNode: messageFocusNode,
                    controller: messageController,
                    validator: ValidatorUtil.validateEmpty,
                    maxLines: maxLines,
                    cursorColor: AppTheme.cursorColor,
                    decoration: InputDecoration(
                      hintText: enterMessage,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppTheme.pinputBorder,
                          width: borderWidth,
                        ),
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppTheme.buttonActive,
                          width: borderWidth,
                        ),
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppTheme.errorColor,
                          width: borderWidth,
                        ),
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppTheme.errorColor,
                          width: borderWidth,
                        ),
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                    onTapOutside: (_) => messageFocusNode.unfocus(),
                  ),
                  if (!isRecurring)
                    Column(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: padding,
                            bottom: smallPadding,
                          ),
                          child: Text(
                            typeTime,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        PinputWidget(
                          controller: pinputController,
                          validator: ValidatorUtil.validatePinput,
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: padding,
                      bottom: smallPadding,
                    ),
                    child: Text(
                      icon,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Row(
                    children: [
                      const IconWidget(),
                      const SizedBox(width: padding),
                      MainTextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return IconStyleBottomSheet(bloc: bloc);
                            },
                          );
                        },
                        text: 'Select icon',
                      )
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.elevatedButtonPadding),
                child: MainButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<NotificationsBloc>(context).add(
                        NotificationsEvent.addNotification(
                          NotificationModel(
                            message: messageController.text,
                            time: DateUtil.toDateTimeFromString(pinputController.text),
                            notificationType: widget.notificationType,
                            icon: BlocProvider.of<IconCubit>(context).previousIcon,
                            backgroundIconColor:
                                BlocProvider.of<IconCubit>(context).previousBackgroundColor,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
