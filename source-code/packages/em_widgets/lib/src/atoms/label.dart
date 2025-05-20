import 'package:em_theme/em_theme.dart';
import 'package:flutter/material.dart';

enum LabelSize { s, m }

class EmLabel extends StatelessWidget {
  final Color color;
  final String label;
  final LabelSize size;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? backgroundColor;

  const EmLabel(
    this.label, {
    required this.color,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.size = LabelSize.m,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final (iconSize, textStyle) = switch (size) {
      LabelSize.s => (12.0, context.textTheme.caption.medium),
      LabelSize.m => (16.0, context.textTheme.labelM),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.textScalerScale(2),
        horizontal: context.textScalerScale(10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor ?? color.withAlpha(36),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: context.textScalerScale(6),
        children: [
          if (prefixIcon != null)
            Icon(
              prefixIcon,
              color: color,
              size: iconSize,
              applyTextScaling: true,
            ),
          Text(label, style: textStyle.withColor(color)),
          if (suffixIcon != null)
            Icon(
              suffixIcon,
              color: color,
              size: iconSize,
              applyTextScaling: true,
            ),
        ],
      ),
    );
  }
}
