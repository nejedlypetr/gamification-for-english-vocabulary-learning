import 'package:em_vocabulary/em_vocabulary.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:english_mind_demo/core/extensions/extensions.dart';
import 'package:english_mind_demo/ui/hooks/audio/use_pronounciation.dart';
import 'package:english_mind_demo/ui/hooks/managers/managers.dart';
import 'package:english_mind_demo/ui/screens/study/widgets/flashcard_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SpellingFlashcard extends HookWidget {
  final VocabularyEntry entry;

  const SpellingFlashcard({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    final manager = useStudyManager();
    final playPronunciation = usePronunciation();

    final focusNode = useFocusNode();
    final textEditingController = useTextEditingController();
    final textController = useListenable(textEditingController);

    final variantState = useState(EmSpellingFlashcardContentVariant.normal);

    useListenable(focusNode);

    void handleSubmission() {
      final variant = variantState.value;
      switch (variant) {
        case EmSpellingFlashcardContentVariant.normal:
          focusNode.unfocus();
          if (textController.value.text == entry.word) {
            variantState.value = EmSpellingFlashcardContentVariant.success;
          } else {
            variantState.value = EmSpellingFlashcardContentVariant.error;
          }
          break;
        case EmSpellingFlashcardContentVariant.success:
        case EmSpellingFlashcardContentVariant.error:
          manager.next();
          break;
      }
    }

    return FlashcardScaffold(
      buttons: EmPrimaryButton(
        size: PrimaryButtonSize.xl,
        onPressed: handleSubmission,
        isDisabled: textController.value.text.isEmpty,
        text: variantState.value == EmSpellingFlashcardContentVariant.normal
            ? context.l10n.checkBtn
            : context.l10n.continueBtn,
      ),
      flashcardType: EmSpellingFlashcard(
        content: EmSpellingFlashcardContent(
          fid: entry.fid,
          word: entry.word,
          focusNode: focusNode,
          variant: variantState.value,
          onSubmitted: handleSubmission,
          textController: textEditingController,
          ipa: entry.usPronunciation.first.ipa,
          errorFeedback: context.l10n.feedbackWrong,
          successFeedback: context.l10n.feedbackCorrect,
          definition: entry.definitions.first.definition,
          hintText: context.l10n.spellingFlashcardHintText,
          onAudioPressed: () => playPronunciation(entry.word),
          exampleSentence: entry.definitions.first.examples.first,
          instructions: context.l10n.spellingFlashcardInstructions,
        ),
      ),
    );
  }
}
