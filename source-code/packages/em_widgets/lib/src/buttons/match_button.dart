import 'package:em_theme/em_theme.dart';
import 'package:flutter/material.dart';

enum MatchButtonVariant { normal, active, correct, incorrect }

class EmMatchButton extends StatelessWidget {
  final String text;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final MatchButtonVariant variant;

  const EmMatchButton({
    required this.text,
    required this.onPressed,
    required this.variant,
    this.isDisabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isInactive = switch (variant) {
      MatchButtonVariant.correct || MatchButtonVariant.incorrect => true,
      _ => false,
    };

    final (textColor, bgColor, borderColor) = switch (variant) {
      MatchButtonVariant.normal => (
          context.colors.text.neutral.primary,
          context.colors.background.lite,
          context.colors.interactive.neutral.primary.withAlpha(50),
        ),
      MatchButtonVariant.active => (
          context.colors.feedback.warning.primary,
          context.colors.feedback.warning.alpha,
          context.colors.feedback.warning.primary.withAlpha(100),
        ),
      MatchButtonVariant.correct => (
          context.colors.feedback.success.primary.withAlpha(80),
          context.colors.feedback.success.alpha,
          context.colors.feedback.success.primary.withAlpha(70),
        ),
      MatchButtonVariant.incorrect => (
          context.colors.feedback.error.primary,
          context.colors.feedback.error.alpha,
          context.colors.feedback.error.primary.withAlpha(100),
        ),
    };

    return Expanded(
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: IgnorePointer(
          ignoring: isDisabled || isInactive,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                backgroundColor: bgColor,
                foregroundColor: textColor,
                visualDensity: VisualDensity.standard,
                padding: EdgeInsets.symmetric(
                  horizontal: context.textScalerScale(10),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(width: 3, color: borderColor),
                ),
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: context.textTheme.labelS.withColor(textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
