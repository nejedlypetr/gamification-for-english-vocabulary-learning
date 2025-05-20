import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'default', type: EmWordProgressTracker)
Widget buildWordProgressTrackerUseCase(BuildContext context) {
  return EmWordProgressTracker(
    label: context.knobs.string(label: 'Label', initialValue: 'Starting'),
    stage: context.knobs.list(
      label: 'Stage',
      options: WordProgressTrackerStage.values,
    ),
  );
}

@widgetbook.UseCase(name: 'default', type: EmTranslationContainer)
Widget buildTranslationContainerUseCase(BuildContext context) {
  return const EmTranslationContainer(
    flagIcon: FlagIcon.czechRepublic,
    translations: ['ahoj', 'dobrý den', 'nazdar'],
  );
}

@widgetbook.UseCase(name: 'default', type: EmFlashcardScaffold)
Widget buildFlashcardScaffoldUseCase(BuildContext context) {
  return HookBuilder(
    builder: (context) {
      final showingFront = useState(true);

      return EmFlashcardScaffold(
        totalCards: 10,
        currentCardIndex: 0,
        onClose: () {},
        onPrevious: () {},
        onSettings: () {},
        buttons: EmPrimaryButton(
          size: PrimaryButtonSize.xl,
          text: showingFront.value ? 'SHOW' : 'HIDE',
          onPressed: () => showingFront.value = !showingFront.value,
        ),
        flashcardType: EmRecallFlashcard(
          isShowingFront: showingFront.value,
          back: EmRecallBackFlashcardContent(
            fid: 100,
            word: 'language',
            onPronunciationPressed: () {},
            definitions: const [
              EmDefinition(
                definition: 'definition',
                examples: ['example 1', 'example 2'],
              ),
              EmDefinition(
                definition: 'definition 2',
                examples: ['example 1', 'example 2', 'example 3'],
              ),
            ],
            partOfSpeechList: const ['noun'],
            pronunciationIpa: 'ˈlæŋɡwɪdʒ',
            showMoreExamplesText: 'Show more examples',
            translation: const EmTranslationContainer(
              flagIcon: FlagIcon.czechRepublic,
              translations: ['ahoj', 'dobrý den', 'nazdar'],
            ),
            wordProgressTracker: EmWordProgressTracker(
              label: 'Starting',
              stage: WordProgressTrackerStage.stage1,
              onTap: () {},
            ),
          ),
          front: const EmRecallFrontFlashcardContent(
            fid: 100,
            instructions: 'Recall the meaning',
            word: 'language',
            partOfSpeechList: ['adjective', 'noun'],
          ),
        ),
      );
    },
  );
}

@widgetbook.UseCase(name: 'default', type: EmFlashcardContainer)
Widget buildFlashcardContainerUseCase(BuildContext context) {
  return Column(
    children: [
      EmFlashcardContainer(
        totalCards: 10,
        onClose: () {},
        onPrevious: () {},
        onSettings: () {},
        currentCardIndex: 0,
        flashcardType: EmRecallFlashcard(
          isShowingFront: false,
          back: EmRecallBackFlashcardContent(
            fid: 100,
            word: 'language',
            definitions: const [
              EmDefinition(
                definition: 'definition',
                examples: ['example 1', 'example 2'],
              ),
              EmDefinition(
                definition: 'definition 2',
                examples: ['example 1', 'example 2', 'example 3'],
              ),
            ],
            pronunciationIpa: 'ˈlæŋɡwɪdʒ',
            partOfSpeechList: const ['noun'],
            onPronunciationPressed: () {},
            showMoreExamplesText: 'Show more examples',
            translation: const EmTranslationContainer(
              flagIcon: FlagIcon.czechRepublic,
              translations: ['ahoj', 'dobrý den', 'nazdar'],
            ),
            wordProgressTracker: EmWordProgressTracker(
              label: 'Starting',
              stage: WordProgressTrackerStage.stage1,
              onTap: () {},
            ),
          ),
          front: const EmRecallFrontFlashcardContent(
            fid: 100,
            instructions: 'Recall the meaning',
            word: 'language',
            partOfSpeechList: ['adjective', 'noun'],
          ),
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'default', type: EmFlashcardSessionStatistics)
Widget buildFlashcardSessionStatisticsUseCase(BuildContext context) {
  return const EmFlashcardSessionStatistics(
    title: 'Well Done!',
    subtitle: "You're building a stronger vocabulary every day!",
    timeSpent: '3:08',
    timeSpentText: 'TIME\nINVESTED',
    wordsReviewed: '9',
    wordsReviewedText: 'WORDS\nREVIEWED',
  );
}
