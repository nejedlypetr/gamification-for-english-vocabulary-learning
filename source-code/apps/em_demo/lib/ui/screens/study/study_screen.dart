import 'package:auto_route/auto_route.dart';
import 'package:em_theme/em_theme.dart';
import 'package:english_mind_demo/domain/entities/study/flashcard_data.dart';
import 'package:english_mind_demo/ui/hooks/managers/managers.dart';
import 'package:english_mind_demo/ui/hooks/study/use_init_study_manager.dart';
import 'package:english_mind_demo/ui/screens/study/widgets/after_practice_review.dart';
import 'package:english_mind_demo/ui/screens/study/widgets/match_definitions_flashcard.dart';
import 'package:english_mind_demo/ui/screens/study/widgets/match_translations_flashcard.dart';
import 'package:english_mind_demo/ui/screens/study/widgets/pronunciation_flashcard.dart';
import 'package:english_mind_demo/ui/screens/study/widgets/recall_flashcard.dart';
import 'package:english_mind_demo/ui/screens/study/widgets/spelling_flashcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class StudyScreen extends HookWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useInitStudyManager();

    final manager = useStudyManager();
    final flashcardDataNotifier = useListenable(manager.flashcardDataNotifier);
    final isFinishedNotifier = useListenable(manager.isFinishedNotifier);

    final flashcardData = flashcardDataNotifier.value;

    return Scaffold(
      backgroundColor: context.colors.background.primary,
      body: isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : isFinishedNotifier.value
              ? const AfterPracticeReview()
              : switch (flashcardData) {
                  final SpellingFlashcardData data =>
                    SpellingFlashcard(entry: data.entry),
                  final MatchDefinitionsFlashcardData data =>
                    MatchDefinitionsFlashcard(entries: data.entries),
                  final MatchTranslationsFlashcardData data =>
                    MatchTranslationsFlashcard(entries: data.entries),
                  final PronunciationFlashcardData data =>
                    PronunciationFlashcard(vocabularyEntry: data.entry),
                  final RecallFlashcardData data => RecallFlashcard(
                      vocabularyEntry: data.entry,
                      flashcardSrsMetadata: data.metadata,
                    ),
                  _ => const SizedBox(child: Text('Unknown flashcard type.')),
                },
    );
  }
}
