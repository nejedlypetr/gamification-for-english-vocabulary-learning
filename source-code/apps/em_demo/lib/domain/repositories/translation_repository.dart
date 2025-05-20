import 'package:english_mind_demo/data/models/translation_entry.dart';

abstract class TranslationRepository {
  Future<TranslationEntry> translate(
    String word,
    TranslationLanguage targetLanguage,
  );
}
