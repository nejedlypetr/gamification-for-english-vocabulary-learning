import 'package:em_theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

enum EmSwipeButtonVariant { learning, known }

class EmSwipeButton extends StatelessWidget {
  final String title;
  final String caption;
  final VoidCallback onPressed;
  final EmSwipeButtonVariant variant;

  const EmSwipeButton({
    required this.title,
    required this.caption,
    required this.variant,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final (bgColor, icon) = switch (variant) {
      EmSwipeButtonVariant.learning => (
          context.colors.feedback.warning.primary,
          HeroiconsSolid.academicCap,
        ),
      EmSwipeButtonVariant.known => (
          context.colors.feedback.success.primary,
          HeroiconsSolid.checkBadge,
        ),
    };

    return InkWell(
      onTap: onPressed,
      splashColor: Colors.white.withValues(alpha: 0.2),
      highlightColor: Colors.white.withValues(alpha: 0.1),
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(28)),
        ),
        child: Column(
          children: [
            const SizedBox.square(dimension: 4),
            Icon(icon, size: 28, color: context.colors.text.neutral.inverted),
            const SizedBox.square(dimension: 10),
            Text(
              caption,
              style: context.textTheme.labelS.copyWith(
                height: 0.9,
                color: context.colors.text.neutral.inverted,
              ),
            ),
            Text(
              title.toUpperCase(),
              style: context.textTheme.title1.bold.withColor(
                context.colors.text.neutral.inverted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
