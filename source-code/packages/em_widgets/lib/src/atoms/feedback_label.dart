import 'package:em_theme/em_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

enum FeedbackLabelVariant { success, error }

class EmFeedbackLabel extends StatelessWidget {
  final String text;
  final FeedbackLabelVariant variant;

  const EmFeedbackLabel({
    required this.text,
    required this.variant,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final color = switch (variant) {
      FeedbackLabelVariant.error => colors.feedback.error.primary,
      FeedbackLabelVariant.success => colors.feedback.success.primary,
    };

    final icon = switch (variant) {
      FeedbackLabelVariant.error => HeroiconsSolid.xCircle,
      FeedbackLabelVariant.success => HeroiconsSolid.checkCircle,
    };

    return Row(
      spacing: context.textScalerScale(8),
      children: [
        Icon(icon, size: 24, applyTextScaling: true, color: color),
        Text(
          text,
          style: context.theme.textTheme.labelM.semiBold.withColor(color),
        ),
      ],
    );
  }
}
