import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'default', type: EmRecallFlashcard)
Widget buildFlashcardContainerContentsUseCase(BuildContext context) {
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
            word: 'language',
            instructions: 'Recall the meaning',
            partOfSpeechList: ['adjective', 'noun'],
          ),
        ),
      );
    },
  );
}

@widgetbook.UseCase(name: 'default', type: EmMatchTranslationsFlashcard)
Widget buildMatchTranslationsFlashcardContentsUseCase(BuildContext context) {
  return HookBuilder(
    builder: (context) {
      final matchComplete = useState(false);

      return EmFlashcardScaffold(
        totalCards: 10,
        currentCardIndex: 0,
        onClose: () {},
        onPrevious: () {},
        onSettings: () {},
        buttons: EmPrimaryButton(
          text: 'CONTINUE',
          onPressed: () {},
          size: PrimaryButtonSize.xl,
          isDisabled: !matchComplete.value,
        ),
        flashcardType: EmMatchTranslationsFlashcard(
          content: EmMatchPairsFlashcardContent(
            equalColumnWidths: true,
            onMatchComplete: () => matchComplete.value = true,
            instructions: context.knobs.string(
              label: 'Instructions',
              initialValue: 'Tap the matching pairs',
            ),
            pairs: const [
              MatchPair(item1: 'hello', item2: 'ahoj'),
              MatchPair(item1: 'world', item2: 'svět'),
              MatchPair(item1: 'language', item2: 'jazyk'),
              MatchPair(item1: 'dog', item2: 'pes'),
              MatchPair(item1: 'cat', item2: 'kočka'),
            ],
          ),
        ),
      );
    },
  );
}

@widgetbook.UseCase(name: 'default', type: EmMatchDefinitionsFlashcard)
Widget buildMatchDefinitionsFlashcardContentsUseCase(BuildContext context) {
  return HookBuilder(
    builder: (context) {
      final matchComplete = useState(false);

      return EmFlashcardScaffold(
        totalCards: 10,
        currentCardIndex: 0,
        onClose: () {},
        onPrevious: () {},
        onSettings: () {},
        buttons: EmPrimaryButton(
          text: 'CONTINUE',
          onPressed: () {},
          size: PrimaryButtonSize.xl,
          isDisabled: !matchComplete.value,
        ),
        flashcardType: EmMatchDefinitionsFlashcard(
          content: EmMatchPairsFlashcardContent(
            onMatchComplete: () => matchComplete.value = true,
            instructions: context.knobs.string(
              label: 'Instructions',
              initialValue: 'Tap the matching pairs',
            ),
            pairs: const [
              MatchPair(item1: 'hello', item2: 'a greeting'),
              MatchPair(item1: 'world', item2: 'a planet where people live'),
              MatchPair(item1: 'language', item2: 'a system of communication'),
              MatchPair(
                item1: 'dog',
                item2: 'a domesticated mammal that barks',
              ),
            ],
          ),
        ),
      );
    },
  );
}

@widgetbook.UseCase(name: 'default', type: EmPronunciationFlashcard)
Widget buildPronunciationFlashcardContentsUseCase(BuildContext context) {
  return EmFlashcardScaffold(
    totalCards: 10,
    currentCardIndex: 0,
    onClose: () {},
    onPrevious: () {},
    onSettings: () {},
    buttons: Row(
      spacing: 10,
      children: [
        Expanded(
          child: EmPrimaryButton(
            text: 'Skip',
            onPressed: () {},
            size: PrimaryButtonSize.xl,
            variant: PrimaryButtonVariant.neutral,
          ),
        ),
        Expanded(
          flex: 3,
          child: EmPrimaryButton(
            onPressed: () {},
            text: 'Pronounce',
            size: PrimaryButtonSize.xl,
            prefixIcon: HeroiconsSolid.microphone,
          ),
        ),
      ],
    ),
    flashcardType: EmPronunciationFlashcard(
      content: EmPronunciationFlashcardContent(
        fid: 100,
        onPronounce: () {},
        word: 'hello',
        ipa: 'hələʊ',
        feedbackCorrect: 'Correct!',
        feedbackIncorrect: 'Incorrect!',
        instructions: 'Pronounce the word',
        partOfSpeechList: const ['noun', 'verb'],
        variant: context.knobs.list(
          label: 'Variant',
          options: EmPronunciationFlashcardContentVariant.values,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'default', type: EmSpellingFlashcard)
Widget buildSpellingFlashcardContentsUseCase(BuildContext context) {
  return EmFlashcardScaffold(
    totalCards: 10,
    currentCardIndex: 0,
    onClose: () {},
    onPrevious: () {},
    onSettings: () {},
    buttons: EmPrimaryButton(
      text: 'CONTINUE',
      onPressed: () {},
      size: PrimaryButtonSize.xl,
    ),
    flashcardType: EmSpellingFlashcard(
      content: EmSpellingFlashcardContent(
        onSubmitted: () {},
        onAudioPressed: () {},
        focusNode: FocusNode(),
        fid: 100,
        ipa: 'hello',
        word: 'hello',
        hintText: 'hint',
        errorFeedback: 'Wrong!',
        successFeedback: 'Correct!',
        instructions: 'Fill the blank',
        exampleSentence: 'Hello, how are you?',
        definition: 'a greeting word that means hello and goodbye and stuff',
        variant: context.knobs.list(
          label: 'Variant',
          options: EmSpellingFlashcardContentVariant.values,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Default', type: EmMenuListContainer)
Widget buildMenuListContainerUseCase(BuildContext context) {
  return SizedBox(
    width: 400,
    child: EmMenuListContainer(
      items: [
        EmMenuListItem(
          title: 'Title',
          trailing: EmIconButton(HeroiconsSolid.chevronRight, onPressed: () {}),
        ),
        EmMenuListItem(
          title: 'Title',
          subtitle: 'Subtitle',
          trailing: EmIconButton(HeroiconsSolid.chevronRight, onPressed: () {}),
        ),
        EmMenuListItem(
          title: 'Title',
          subtitle: 'Subtitle',
          leading: const Icon(HeroiconsSolid.academicCap),
          trailing: EmIconButton(HeroiconsSolid.chevronRight, onPressed: () {}),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Default', type: EmSelectListItem)
Widget buildSelectListItemUseCase(BuildContext context) {
  return EmSelectListItem(
    text: 'Title',
    onPressed: () {},
    isSelected: context.knobs.boolean(label: 'Is Selected'),
    leading: const EmFlagIcon(FlagIcon.czechRepublic, size: FlagIconSize.l),
  );
}
