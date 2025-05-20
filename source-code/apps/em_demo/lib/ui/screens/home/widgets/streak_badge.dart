import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:english_mind_demo/core/extensions/extensions.dart';
import 'package:english_mind_demo/ui/hooks/managers/managers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StreakBadge extends HookWidget {
  const StreakBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final streakManager = useStreakManager();

    final currentStreakAsync = useFuture(streakManager.getCurrentStreak(''));
    final currentStreak = currentStreakAsync.data;

    final isStreakActiveAsync = useFuture(streakManager.isStreakActive(''));
    final isStreakActive = isStreakActiveAsync.data ?? false;

    return EmStreakBadge(
      streakCount: currentStreak ?? 0,
      streakText: context.l10n.streakBadgeText,
      variant: isStreakActive
          ? EmStreakBadgeVariant.active
          : EmStreakBadgeVariant.inactive,
      onTap: () => isStreakActive
          ? null
          : showModalBottomSheet(
              context: context,
              backgroundColor: context.colors.background.inverted,
              builder: (context) => EmStreakBottomSheet(
                title: context.l10n.streakBottomSheetTitle,
                variant: EmStreakBottomSheetVariant.inactivated,
                subtitle: context.l10n.streakBottomSheetSubtitle,
                buttonText: context.l10n.streakBottomSheetButtonText,
                instruction1: context.l10n.streakBottomSheetInstruction1,
                instruction2: context.l10n.streakBottomSheetInstruction2,
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.l10n.streakBottomSheetSnackbarText),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
