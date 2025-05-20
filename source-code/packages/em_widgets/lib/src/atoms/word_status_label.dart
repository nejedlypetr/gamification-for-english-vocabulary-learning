import 'package:em_theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

enum WordStatusLabelVariant { known, learning, unseen }

class EmWordStatusLabel extends StatelessWidget {
  final int? count;
  final String label;
  final bool isLoading;
  final WordStatusLabelVariant variant;

  const EmWordStatusLabel({
    required this.label,
    required this.variant,
    this.count,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors.feedback;

    final (icon, color, backgroundColor) = switch (variant) {
      WordStatusLabelVariant.known => (
          HeroiconsSolid.checkBadge,
          colors.success.primary,
          colors.success.alpha
        ),
      WordStatusLabelVariant.learning => (
          HeroiconsSolid.academicCap,
          colors.warning.primary,
          colors.warning.alpha
        ),
      WordStatusLabelVariant.unseen => (
          HeroiconsSolid.eyeSlash,
          colors.neutral.primary,
          colors.neutral.alpha
        ),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.textScalerScale(2),
        horizontal: context.textScalerScale(10),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: context.textScalerScale(6),
        children: [
          Icon(icon, size: 16, color: color, applyTextScaling: true),
          if (isLoading)
            SizedBox(
              height: context.textScalerScale(14),
              child: FittedBox(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ),
          Text(
            (count == null || isLoading) ? label : '$count $label',
            style: context.textTheme.labelS.withColor(color),
          ),
        ],
      ),
    );
  }
}
