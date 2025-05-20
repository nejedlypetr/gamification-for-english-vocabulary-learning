import 'package:em_vocabulary/em_vocabulary.dart';
import 'package:english_mind_demo/data/models/flashcard_srs_metadata.dart';

sealed class FlashcardData {}

class RecallFlashcardData extends FlashcardData {
  final VocabularyEntry entry;
  final FlashcardSrsMetadata metadata;

  RecallFlashcardData({required this.entry, required this.metadata});
}

class SpellingFlashcardData extends FlashcardData {
  final VocabularyEntry entry;

  SpellingFlashcardData(this.entry);
}

class PronunciationFlashcardData extends FlashcardData {
  final VocabularyEntry entry;

  PronunciationFlashcardData(this.entry);
}

class MatchDefinitionsFlashcardData extends FlashcardData {
  final List<VocabularyEntry> entries;

  MatchDefinitionsFlashcardData(this.entries);
}

class MatchTranslationsFlashcardData extends FlashcardData {
  final List<VocabularyEntry> entries;

  MatchTranslationsFlashcardData(this.entries);
}
