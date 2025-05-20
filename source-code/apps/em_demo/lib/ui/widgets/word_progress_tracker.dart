import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:english_mind_demo/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

class WordProgressTracker extends StatelessWidget {
  final WordProgressTrackerStage stage;

  const WordProgressTracker(this.stage, {super.key});

  @override
  Widget build(BuildContext context) {
    final label = switch (stage) {
      WordProgressTrackerStage.stage1 => context.l10n.wordProgressTrackerStage1,
      WordProgressTrackerStage.stage2 => context.l10n.wordProgressTrackerStage2,
      WordProgressTrackerStage.stage3 => context.l10n.wordProgressTrackerStage3,
      WordProgressTrackerStage.stage4 => context.l10n.wordProgressTrackerStage4,
      WordProgressTrackerStage.stage5 => context.l10n.wordProgressTrackerStage5,
    };

    return EmWordProgressTracker(
      label: label,
      stage: stage,
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: context.theme.colors.background.inverted,
        builder: (context) => EmWordProgressTrackerBottomSheet(
          title: context.l10n.wordProgressTrackerBottomSheetTitle,
          intervalLabel: context.l10n.wordProgressTrackerIntervalLabel,
          explanationText: context.l10n.wordProgressTrackerExplanationText,
          items: [
            WordProgressTrackerBottomSheetItem(
              stage: WordProgressTrackerStage.stage1,
              stageLabel: context.l10n.wordProgressTrackerStage1,
              interval: context.l10n.wordProgressTrackerStage1Interval,
            ),
            WordProgressTrackerBottomSheetItem(
              stage: WordProgressTrackerStage.stage2,
              stageLabel: context.l10n.wordProgressTrackerStage2,
              interval: context.l10n.wordProgressTrackerStage2Interval,
            ),
            WordProgressTrackerBottomSheetItem(
              stage: WordProgressTrackerStage.stage3,
              stageLabel: context.l10n.wordProgressTrackerStage3,
              interval: context.l10n.wordProgressTrackerStage3Interval,
            ),
            WordProgressTrackerBottomSheetItem(
              stage: WordProgressTrackerStage.stage4,
              stageLabel: context.l10n.wordProgressTrackerStage4,
              interval: context.l10n.wordProgressTrackerStage4Interval,
            ),
            WordProgressTrackerBottomSheetItem(
              stage: WordProgressTrackerStage.stage5,
              stageLabel: context.l10n.wordProgressTrackerStage5,
              interval: context.l10n.wordProgressTrackerStage5Interval,
            ),
          ],
        ),
      ),
    );
  }
}
