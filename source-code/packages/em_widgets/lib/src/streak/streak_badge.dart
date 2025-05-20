import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

enum EmStreakBadgeVariant { active, inactive }

class EmStreakBadge extends StatelessWidget {
  final bool isLoading;
  final int streakCount;
  final String streakText;
  final VoidCallback? onTap;
  final EmStreakBadgeVariant variant;

  const EmStreakBadge({
    required this.streakText,
    required this.streakCount,
    this.onTap,
    this.isLoading = false,
    this.variant = EmStreakBadgeVariant.active,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final (shinyBadgeVariant, textColor, iconColor, catEmoji) =
        switch (variant) {
      EmStreakBadgeVariant.active => (
          EmShinyBadgeVariant.gold,
          Colors.white,
          context.colors.feedback.warning.primary,
          CatEmoji.party,
        ),
      EmStreakBadgeVariant.inactive => (
          EmShinyBadgeVariant.faded,
          Colors.grey.shade500,
          Colors.grey.shade500,
          CatEmoji.upset,
        ),
    };

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: EmShinyBadge(
        variant: shinyBadgeVariant,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: Row(
            children: [
              Icon(HeroiconsSolid.fire, size: 56, color: iconColor),
              const SizedBox.square(dimension: 10),
              Text(
                streakCount.toString(),
                style: context.textTheme.title1.copyWith(
                  fontSize: 48,
                  color: textColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox.square(dimension: 8),
              Expanded(
                child: Text(
                  streakText,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelL.bold.copyWith(
                    height: 1.0,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox.square(dimension: 4),
              if (variant == EmStreakBadgeVariant.inactive)
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.grey.withAlpha(120),
                    BlendMode.srcATop,
                  ),
                  child: EmCatEmoji(catEmoji),
                )
              else
                EmCatEmoji(catEmoji),
            ],
          ),
        ),
      ),
    );
  }
}
