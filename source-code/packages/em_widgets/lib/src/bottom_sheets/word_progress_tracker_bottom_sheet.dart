import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class WordProgressTrackerBottomSheetItem {
  final String interval;
  final String stageLabel;
  final WordProgressTrackerStage stage;

  const WordProgressTrackerBottomSheetItem({
    required this.stage,
    required this.interval,
    required this.stageLabel,
  });
}

class EmWordProgressTrackerBottomSheet extends StatelessWidget {
  final String title;
  final String intervalLabel;
  final String explanationText;
  final List<WordProgressTrackerBottomSheetItem> items;

  const EmWordProgressTrackerBottomSheet({
    required this.items,
    required this.title,
    required this.intervalLabel,
    required this.explanationText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors.progressTracker;

    return EmBottomSheet(
      title: title,
      prefixIcon: const EmCircularIcon(HeroiconsSolid.informationCircle),
      content: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final i in items)
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EmWordProgressTracker(
                  stage: i.stage,
                  label: i.stageLabel,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      intervalLabel,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.footnote.withColor(
                        context.colors.text.neutral.primary,
                      ),
                    ),
                    Text(
                      i.interval,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelS.semiBold.withColor(
                        switch (i.stage) {
                          WordProgressTrackerStage.stage1 => colors.stage1,
                          WordProgressTrackerStage.stage2 => colors.stage2,
                          WordProgressTrackerStage.stage3 => colors.stage3,
                          WordProgressTrackerStage.stage4 => colors.stage4,
                          WordProgressTrackerStage.stage5 => colors.stage5,
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          Text(
            explanationText,
            textAlign: TextAlign.center,
            style: context.textTheme.labelS,
          ),
        ],
      ),
    );
  }
}
