import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:english_mind_demo/core/extensions/extensions.dart';
import 'package:english_mind_demo/ui/hooks/managers/managers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class AfterPracticeStreak extends HookWidget {
  final void Function() onFinish;

  const AfterPracticeStreak({
    required this.onFinish,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final manager = useStreakManager();

    final currentStreak = useFuture(manager.getCurrentStreak(''));
    final streak = currentStreak.data;

    return SafeArea(
      minimum: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ).copyWith(bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          const SizedBox.shrink(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                HeroiconsSolid.fire,
                size: 120,
                color: context.colors.feedback.warning.primary,
              ),
              Row(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    streak.toString(),
                    style: context.textTheme.title1.copyWith(
                      fontSize: 72,
                      fontWeight: FontWeight.w900,
                      color: context.colors.feedback.warning.primary,
                    ),
                  ),
                  Text(
                    context.l10n.streakBadgeText,
                    style: context.textTheme.title2.copyWith(
                      fontSize: 28,
                      height: 28 / 28,
                      fontWeight: FontWeight.w900,
                      color: context.colors.feedback.warning.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            spacing: 30,
            children: [
              const CalendarWeekStreak(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: context.textTheme.labelM.medium,
                    children: [
                      TextSpan(text: context.l10n.streakExplanationPart1),
                      TextSpan(
                        text: context.l10n.streakExplanationHighlightedWord,
                        style: context.textTheme.labelM.semiBold.withColor(
                          context.colors.feedback.warning.primary,
                        ),
                      ),
                      TextSpan(text: context.l10n.streakExplanationPart2),
                    ],
                  ),
                ),
              ),
            ],
          ),
          EmPrimaryButton(
            onPressed: onFinish,
            size: PrimaryButtonSize.xl,
            text: context.l10n.continueBtn,
          ),
        ],
      ),
    );
  }
}

class CalendarWeekStreak extends HookWidget {
  const CalendarWeekStreak({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = useStreakManager();

    final weeklyStreak = useFuture(manager.getWeeklyStreakData(''));
    final weeklyStreakData = weeklyStreak.data;

    final l10n = context.l10n;

    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    final days = <String, DateTime>{
      l10n.weekdayShortMonday: startOfWeek,
      l10n.weekdayShortTuesday: startOfWeek.add(const Duration(days: 1)),
      l10n.weekdayShortWednesday: startOfWeek.add(const Duration(days: 2)),
      l10n.weekdayShortThursday: startOfWeek.add(const Duration(days: 3)),
      l10n.weekdayShortFriday: startOfWeek.add(const Duration(days: 4)),
      l10n.weekdayShortSaturday: startOfWeek.add(const Duration(days: 5)),
      l10n.weekdayShortSunday: startOfWeek.add(const Duration(days: 6)),
    };

    if (weeklyStreakData == null) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        for (final day in days.entries)
          DayCheckBox(
            day: day.key,
            variant: weeklyStreakData[day.value.weekday - 1]
                ? DayCheckBoxVariant.success
                : day.value.isBefore(now)
                    ? DayCheckBoxVariant.failed
                    : DayCheckBoxVariant.normal,
          ),
      ],
    );
  }
}

enum DayCheckBoxVariant { success, failed, normal }

class DayCheckBox extends StatelessWidget {
  final String day;
  final DayCheckBoxVariant variant;

  const DayCheckBox({required this.day, required this.variant, super.key});

  @override
  Widget build(BuildContext context) {
    final color = switch (variant) {
      DayCheckBoxVariant.success => context.colors.feedback.warning.primary,
      DayCheckBoxVariant.failed => context.colors.feedback.error.primary,
      DayCheckBoxVariant.normal => context.colors.interactive.neutral.disabled,
    };

    return Column(
      spacing: 8,
      children: [
        Text(day, style: context.textTheme.labelS.semiBold.withColor(color)),
        switch (variant) {
          DayCheckBoxVariant.success => Icon(
              HeroiconsSolid.checkCircle,
              size: 28,
              color: color,
            ),
          DayCheckBoxVariant.failed => Icon(
              HeroiconsSolid.xCircle,
              size: 28,
              color: color,
            ),
          _ => Container(
              height: 22.5,
              width: 22.5,
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withAlpha(160),
              ),
            ),
        },
      ],
    );
  }
}
