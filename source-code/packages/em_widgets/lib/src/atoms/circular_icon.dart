import 'package:em_theme/em_theme.dart';
import 'package:flutter/material.dart';

enum EmCircularIconVariant { info, success, error, warning, neutral }

class EmCircularIcon extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final EmCircularIconVariant variant;

  const EmCircularIcon(
    this.icon, {
    this.iconColor,
    this.backgroundColor,
    this.variant = EmCircularIconVariant.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors.feedback;
    final (iColor, bgColor) = switch (variant) {
      EmCircularIconVariant.info => (colors.info.primary, colors.info.alpha),
      EmCircularIconVariant.error => (colors.error.primary, colors.error.alpha),
      EmCircularIconVariant.warning => (
          colors.warning.primary,
          colors.warning.alpha,
        ),
      EmCircularIconVariant.success => (
          colors.success.primary,
          colors.success.alpha,
        ),
      EmCircularIconVariant.neutral => (
          colors.neutral.primary,
          colors.neutral.alpha,
        ),
    };

    return Container(
      width: context.textScalerScale(32),
      height: context.textScalerScale(32),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? bgColor,
      ),
      child: Icon(
        icon,
        size: 20,
        applyTextScaling: true,
        color: iconColor ?? iColor,
      ),
    );
  }
}
