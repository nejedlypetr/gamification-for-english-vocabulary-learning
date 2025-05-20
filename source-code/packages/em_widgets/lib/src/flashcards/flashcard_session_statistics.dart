import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class EmFlashcardSessionStatistics extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeSpent;
  final String timeSpentText;
  final String wordsReviewed;
  final String wordsReviewedText;

  const EmFlashcardSessionStatistics({
    required this.title,
    required this.subtitle,
    required this.timeSpent,
    required this.timeSpentText,
    required this.wordsReviewed,
    required this.wordsReviewedText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(130),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 6,
          color: context.theme.colors.feedback.warning.primary.withAlpha(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.theme.textTheme.title1.extraBold.copyWith(
              fontSize: 32,
              color: context.theme.colors.feedback.warning.primary,
            ),
          ),
          const SizedBox.square(dimension: 16),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: context.theme.textTheme.labelL.medium,
          ),
          const SizedBox.square(dimension: 24),
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    wordsReviewed,
                    style: context.theme.textTheme.title1.bold.withColor(
                      context.theme.colors.feedback.success.primary,
                    ),
                  ),
                  Text(
                    timeSpent,
                    style: context.theme.textTheme.title1.bold.withColor(
                      context.theme.colors.progressTracker.stage1,
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Label(
                    label: wordsReviewedText,
                    icon: HeroiconsSolid.square3Stack3d,
                    color: context.theme.colors.feedback.success.primary,
                    backgroundColor: context.colors.feedback.success.alpha,
                  ),
                  _Label(
                    label: timeSpentText,
                    icon: HeroiconsSolid.clock,
                    color: context.theme.colors.progressTracker.stage1,
                    backgroundColor: context.colors.progressTracker.stage1Alpha,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;
  final Color backgroundColor;

  const _Label({
    required this.icon,
    required this.label,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EmCircularIcon(
          icon,
          iconColor: color,
          backgroundColor: backgroundColor,
        ),
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: context.theme.textTheme.caption.bold.withColor(color),
        ),
      ],
    );
  }
}
