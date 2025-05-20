import 'package:em_theme/em_theme.dart';
import 'package:flutter/material.dart';

class EmAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

  const EmAppBar({this.title, this.actions, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final titleText = title;

    return AppBar(
      actions: actions,
      actionsPadding: const EdgeInsets.only(right: 16),
      title: titleText != null
          ? Text(titleText, style: context.textTheme.title1)
          : null,
    );
  }
}
