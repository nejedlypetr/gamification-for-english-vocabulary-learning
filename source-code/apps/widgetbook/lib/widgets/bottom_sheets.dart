import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'default', type: EmBottomSheet)
Widget buildBottomSheetUseCase(BuildContext context) {
  return TextButton(
    child: const Text('Open Bottom Sheet'),
    onPressed: () {
      showModalBottomSheet(
        context: context,
        builder: (context) => EmBottomSheet(
          title: context.knobs.string(label: 'Title', initialValue: 'Title'),
          content: const Text('Content is here...'),
        ),
      );
    },
  );
}

@widgetbook.UseCase(name: 'default', type: EmWordProgressTrackerBottomSheet)
Widget buildWordProgressTrackerBottomSheetUseCase(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Word Progress Tracker',
  );

  return TextButton(
    child: const Text('Open Bottom Sheet'),
    onPressed: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => EmWordProgressTrackerBottomSheet(
          title: title,
          items: const [
            WordProgressTrackerBottomSheetItem(
              stage: WordProgressTrackerStage.stage1,
              stageLabel: 'Starting',
              interval: 'now - 3 days',
            ),
            WordProgressTrackerBottomSheetItem(
              stage: WordProgressTrackerStage.stage2,
              stageLabel: 'Familiarizing',
              interval: '3 days - 1 week',
            ),
            WordProgressTrackerBottomSheetItem(
              stage: WordProgressTrackerStage.stage3,
              stageLabel: 'Reinforcing',
              interval: '1 week - 3 weeks',
            ),
            WordProgressTrackerBottomSheetItem(
              stage: WordProgressTrackerStage.stage4,
              stageLabel: 'Strengthening',
              interval: '3 weeks - 3 months',
            ),
            WordProgressTrackerBottomSheetItem(
              stage: WordProgressTrackerStage.stage5,
              stageLabel: 'Mastering',
              interval: '3 - 8 months',
            ),
          ],
          intervalLabel: context.knobs.string(
            label: 'Interval Label',
            initialValue: 'Review interval',
          ),
          explanationText: context.knobs.string(
            label: 'Explanation Text',
            initialValue: 'Words passing the 8-month interval'
                ' are marked as "KNOWN" and no longer need regular reviews.',
          ),
        ),
      );
    },
  );
}

@widgetbook.UseCase(name: 'default', type: EmStreakBottomSheet)
Widget buildStreakBottomSheetUseCase(BuildContext context) {
  final variant = context.knobs.list(
    label: 'Variant',
    options: EmStreakBottomSheetVariant.values,
  );

  return TextButton(
    child: const Text('Open Bottom Sheet'),
    onPressed: () {
      showModalBottomSheet(
        context: context,
        builder: (context) => EmStreakBottomSheet(
          variant: variant,
          onPressed: () {},
          title: 'Activate your STREAK!',
          buttonText: 'Go add a new word',
          subtitle: 'To activate and maintain streak:',
          instruction1: '1) Add a new word to your learning list',
          instruction2: '2) Review the new word in the flashcard queue',
        ),
      );
    },
  );
}
