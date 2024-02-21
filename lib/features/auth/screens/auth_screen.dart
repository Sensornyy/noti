import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noti/core/shared_widgets/loading_indicator.dart';
import 'package:noti/core/shared_widgets/main_app_bar.dart';
import 'package:noti/core/shared_widgets/main_button.dart';
import 'package:noti/core/style/app_theme.dart';
import 'package:noti/features/auth/bloc/auth_bloc.dart';
import 'package:noti/features/auth/widgets/error_bar_widget.dart';
import 'package:noti/core/shared_widgets/pinput_widget.dart';
import 'package:noti/features/auth/widgets/current_time_widget.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  static const String _title = 'Log In';
  static const String _subtitle = 'Enter current time in hh : mm format';
  static const String _success = 'Success';
  static const String _continue = 'Continue';
  static const double _subtitleSize = 16.0;
  static const double _titlePadding = 60.0;
  static const double _subtitlePadding = 20.0;
  static const double _timePadding = 40.0;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return SafeArea(
      child: Scaffold(
        appBar: const MainAppBar(
          title: _title,
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: _titlePadding),
                    child: Text(
                      _title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: _subtitlePadding),
                    child: Text(
                      _subtitle,
                      style: AppTheme.greyTextStyle.copyWith(fontSize: _subtitleSize),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: _timePadding),
                    child: CurrentTimeWidget(),
                  ),
                  PinputWidget(controller: controller),
                ],
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.maybeWhen(
                  error: () => const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: AppTheme.errorBarPadding),
                      child: ErrorBarWidget(),
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.elevatedButtonPadding),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return MainButton(
                      onPressed: state.maybeWhen(
                        disabled: () => null,
                        enabled: () => () => authBloc.add(AuthEvent.logIn(controller.text)),
                        orElse: () => () {},
                      ),
                      child: state.maybeWhen(
                        loading: () => const LoadingIndicator(),
                        success: () => const Text(_success),
                        orElse: () => const Text(_continue),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
