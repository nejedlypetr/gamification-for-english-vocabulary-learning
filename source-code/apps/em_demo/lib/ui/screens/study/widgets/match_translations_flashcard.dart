import 'package:em_vocabulary/em_vocabulary.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:english_mind_demo/core/extensions/extensions.dart';
import 'package:english_mind_demo/ui/hooks/managers/managers.dart';
import 'package:english_mind_demo/ui/screens/study/widgets/flashcard_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MatchTranslationsFlashcard extends HookWidget {
  final List<VocabularyEntry> entries;

  const MatchTranslationsFlashcard({required this.entries, super.key});

  @override
  Widget build(BuildContext context) {
    final manager = useStudyManager();
    final isMatchingCompleteState = useState(false);

    final translationManager = useTranslationManager();
    final pairsRef = useState<List<MatchPair>>([]);

    useEffect(
      () {
        Future.microtask(() async {
          final futures = entries.map(
            (e) async {
              final translation = await translationManager.translate(e.word);
              return MatchPair(
                item1: e.word,
                item2: translation.translations.first,
              );
            },
          ).toList();

          final pairsData = await Future.wait(futures);
          pairsRef.value = pairsData;
        });

        return null;
      },
      [entries],
    );

    return FlashcardScaffold(
      buttons: EmPrimaryButton(
        onPressed: manager.next,
        size: PrimaryButtonSize.xl,
        text: context.l10n.continueBtn,
        isDisabled: !isMatchingCompleteState.value,
      ),
      flashcardType: EmMatchDefinitionsFlashcard(
        content: EmMatchPairsFlashcardContent(
          pairs: pairsRef.value,
          equalColumnWidths: true,
          instructions: context.l10n.matchPairsFlashcardInstructions,
          onMatchComplete: () => isMatchingCompleteState.value = true,
        ),
      ),
    );
  }
}
