import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    required this.title,
    this.toolbarHeight,
    this.child,
    this.leading,
    Key? key,
  }) : super(key: key);

  final String title;
  final double? toolbarHeight;
  final Widget? child;
  final Widget? leading;

  static const double _topPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      leading: leading,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: _topPadding),
        child: Column(
          children: [
            Text(title),
            child ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
