import 'package:flutter/cupertino.dart';
import 'package:noti/core/style/app_theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(color: AppTheme.indicatorColor);
  }
}
