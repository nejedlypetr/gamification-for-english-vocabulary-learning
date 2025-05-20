import 'package:em_vocabulary/em_vocabulary.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:english_mind_demo/core/extensions/extensions.dart';
import 'package:english_mind_demo/data/models/flashcard_srs_metadata.dart';
import 'package:english_mind_demo/ui/hooks/audio/use_pronounciation.dart';
import 'package:english_mind_demo/ui/hooks/managers/managers.dart';
import 'package:english_mind_demo/ui/screens/study/widgets/flashcard_scaffold.dart';
import 'package:english_mind_demo/ui/widgets/translation_container.dart';
import 'package:english_mind_demo/ui/widgets/word_progress_tracker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RecallFlashcard extends HookWidget {
  final VocabularyEntry vocabularyEntry;
  final FlashcardSrsMetadata flashcardSrsMetadata;

  const RecallFlashcard({
    required this.vocabularyEntry,
    required this.flashcardSrsMetadata,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final manager = useStudyManager();
    final playPronunciation = usePronunciation();

    final showingFrontState = useState(true);
    final isShowingFront = showingFrontState.value;

    return FlashcardScaffold(
      onPrevious: () => showingFrontState.value = true,
      buttons: isShowingFront
          ? EmPrimaryButton(
              size: PrimaryButtonSize.xl,
              text: context.l10n.showBtn,
              onPressed: () {
                showingFrontState.value = false;
                playPronunciation(
                  vocabularyEntry.usPronunciation.first.audio ??
                      vocabularyEntry.word.toLowerCase(),
                );
              },
            )
          : Row(
              spacing: 10,
              children: [
                Flexible(
                  child: EmPrimaryButton(
                    size: PrimaryButtonSize.xl,
                    text: context.l10n.recallWrongButton,
                    variant: PrimaryButtonVariant.errorSolid,
                    onPressed: () {
                      showingFrontState.value = true;
                      manager.next();
                    },
                  ),
                ),
                Flexible(
                  child: EmPrimaryButton(
                    size: PrimaryButtonSize.xl,
                    text: context.l10n.recallCorrectButton,
                    variant: PrimaryButtonVariant.successSolid,
                    onPressed: () {
                      showingFrontState.value = true;
                      manager.next();
                    },
                  ),
                ),
              ],
            ),
      flashcardType: EmRecallFlashcard(
        isShowingFront: isShowingFront,
        front: EmRecallFrontFlashcardContent(
          fid: vocabularyEntry.fid,
          word: vocabularyEntry.word,
          partOfSpeechList: vocabularyEntry.partOfSpeech,
          instructions: context.l10n.recallFlashcardInstructions,
        ),
        back: EmRecallBackFlashcardContent(
          fid: vocabularyEntry.fid,
          word: vocabularyEntry.word,
          partOfSpeechList: vocabularyEntry.partOfSpeech,
          showMoreExamplesText: context.l10n.showMoreExamples,
          definitions: vocabularyEntry.definitions.toEmDefinitions(),
          pronunciationIpa: vocabularyEntry.usPronunciation.first.ipa,
          translation: TranslationContainer(word: vocabularyEntry.word),
          wordProgressTracker: WordProgressTracker(flashcardSrsMetadata.stage),
          onPronunciationPressed: () => playPronunciation(
            vocabularyEntry.usPronunciation.first.audio ??
                vocabularyEntry.word.toLowerCase(),
          ),
        ),
      ),
    );
  }
}
