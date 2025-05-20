import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';

class EmMenuListContainer extends StatelessWidget {
  final List<Widget> items;
  final BorderRadiusGeometry? borderRadius;

  const EmMenuListContainer({
    required this.items,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.background.inverted,
        borderRadius: borderRadius ?? BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final item in items) ...[
            item,
            if (item != items.last) const EmDivider(),
          ],
        ],
      ),
    );
  }
}

class EmMenuListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const EmMenuListItem({
    required this.title,
    this.onTap,
    this.leading,
    this.trailing,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final subtitleText = subtitle;
    final leadingWidget = leading;
    final trailingWidget = trailing;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          spacing: 12,
          children: [
            if (leadingWidget != null) leadingWidget,
            if (subtitleText != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleStyle ?? context.textTheme.labelM.medium,
                    ),
                    Text(
                      subtitleText,
                      style: subtitleStyle ?? context.textTheme.labelS.regular,
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: Text(
                  title,
                  style: titleStyle ?? context.textTheme.labelM,
                ),
              ),
            if (trailingWidget != null) trailingWidget,
          ],
        ),
      ),
    );
  }
}
