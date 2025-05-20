import 'package:em_theme/em_theme.dart';
import 'package:flutter/material.dart';

enum EmIconButtonSize { s, m, l }

enum EmIconButtonVariant { neutral, neutralDark, error }

class EmIconButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final EmIconButtonSize size;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final EmIconButtonVariant variant;

  const EmIconButton(
    this.icon, {
    required this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size = EmIconButtonSize.m,
    this.variant = EmIconButtonVariant.neutral,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final (fixedSize, iconSize) = switch (size) {
      EmIconButtonSize.s => (36.0, 18.0),
      EmIconButtonSize.m => (40.0, 20.0),
      EmIconButtonSize.l => (48.0, 24.0),
    };

    final (backgroundColorVariant, iconColorVariant) = switch (variant) {
      EmIconButtonVariant.neutral => (
          context.colors.background.lite,
          context.colors.interactive.neutral.primary
        ),
      EmIconButtonVariant.neutralDark => (
          context.colors.interactive.neutral.primary.withAlpha(30),
          context.colors.interactive.neutral.primary,
        ),
      EmIconButtonVariant.error => (
          context.colors.feedback.error.primary.withAlpha(30),
          context.colors.feedback.error.primary,
        ),
    };

    return IconButton(
      constraints: BoxConstraints(
        minWidth: context.textScalerScale(fixedSize),
        minHeight: context.textScalerScale(fixedSize),
        maxWidth: context.textScalerScale(fixedSize),
        maxHeight: context.textScalerScale(fixedSize),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: iconSize,
        applyTextScaling: true,
        color: iconColor ?? iconColorVariant,
      ),
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fixedSize: Size.square(context.textScalerScale(fixedSize)),
        backgroundColor: backgroundColor ?? backgroundColorVariant,
      ),
    );
  }
}
