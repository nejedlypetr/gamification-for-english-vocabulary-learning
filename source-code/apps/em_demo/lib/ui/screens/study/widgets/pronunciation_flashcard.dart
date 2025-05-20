import 'package:em_vocabulary/em_vocabulary.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:english_mind_demo/core/extensions/extensions.dart';
import 'package:english_mind_demo/ui/hooks/audio/use_pronounciation.dart';
import 'package:english_mind_demo/ui/hooks/managers/managers.dart';
import 'package:english_mind_demo/ui/screens/study/widgets/flashcard_scaffold.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:speech_to_text/speech_to_text.dart';

class PronunciationFlashcard extends HookWidget {
  final VocabularyEntry vocabularyEntry;

  const PronunciationFlashcard({
    required this.vocabularyEntry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final manager = useStudyManager();
    final playPronunciation = usePronunciation();
    final speechToText = useMemoized(SpeechToText.new);

    final isListening = useState(false);
    final variantState =
        useState(EmPronunciationFlashcardContentVariant.initial);

    useEffect(
      () {
        speechToText.initialize(onError: (e) => debugPrint('T2S error: $e'));

        speechToText.statusListener = (status) {
          debugPrint('T2S status: $status');

          switch (status) {
            case 'listening':
              isListening.value = true;
              break;
            case 'notListening' || 'done':
              isListening.value = false;
              if (variantState.value ==
                  EmPronunciationFlashcardContentVariant.initial) {
                variantState.value =
                    EmPronunciationFlashcardContentVariant.incorrect;
              }
              break;
          }
        };

        return speechToText.cancel;
      },
      [],
    );

    final startListening = useCallback(
      () async {
        final available = await speechToText.initialize();

        // TODO: handle not available or does not have premissions, show a bottom sheet.

        if (available) {
          isListening.value = true;
          const maxDuration = Duration(seconds: 5);

          speechToText.listen(
            localeId: 'en-US', // 'en-US', 'en-GB'
            listenFor: maxDuration,
            onResult: (result) {
              debugPrint('T2S result: ${result.recognizedWords}');

              final recording = result.recognizedWords.toLowerCase();
              if (recording.contains(vocabularyEntry.word.toLowerCase())) {
                variantState.value =
                    EmPronunciationFlashcardContentVariant.correct;
                speechToText.cancel();
              }
            },
          );
        }
      },
      [speechToText, vocabularyEntry],
    );

    final buttons = switch (variantState.value) {
      EmPronunciationFlashcardContentVariant.initial ||
      EmPronunciationFlashcardContentVariant.incorrect =>
        Row(
          spacing: 10,
          children: [
            Expanded(
              flex: 2,
              child: EmPrimaryButton(
                onPressed: manager.next,
                size: PrimaryButtonSize.xl,
                text: context.l10n.skipButton,
                variant: PrimaryButtonVariant.neutral,
              ),
            ),
            Expanded(
              flex: 4,
              child: EmPrimaryButton(
                size: PrimaryButtonSize.xl,
                prefixIcon: HeroiconsSolid.microphone,
                onPressed: isListening.value ? null : startListening,
                text: isListening.value
                    ? context.l10n.recordingButton
                    : variantState.value ==
                            EmPronunciationFlashcardContentVariant.initial
                        ? context.l10n.pronounceButton
                        : context.l10n.tryAgainButton,
              ),
            ),
          ],
        ),
      EmPronunciationFlashcardContentVariant.correct => EmPrimaryButton(
          onPressed: manager.next,
          size: PrimaryButtonSize.xl,
          text: context.l10n.continueBtn,
        ),
    };

    return FlashcardScaffold(
      buttons: buttons,
      flashcardType: EmPronunciationFlashcard(
        content: EmPronunciationFlashcardContent(
          fid: vocabularyEntry.fid,
          word: vocabularyEntry.word,
          variant: variantState.value,
          feedbackCorrect: context.l10n.feedbackCorrect,
          feedbackIncorrect: context.l10n.feedbackWrong,
          partOfSpeechList: vocabularyEntry.partOfSpeech,
          ipa: vocabularyEntry.usPronunciation.first.ipa, // TODO
          instructions: context.l10n.pronunciationFlashcardInstructions,
          onPronounce: () => playPronunciation(
            vocabularyEntry.usPronunciation.first.audio ??
                vocabularyEntry.word.toLowerCase(),
          ),
        ),
      ),
    );
  }
}
