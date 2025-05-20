import 'package:english_mind_demo/data/models/translation_entry.dart';
import 'package:english_mind_demo/domain/repositories/translation_repository.dart';

class TranslationManager {
  final TranslationRepository _repository;

  TranslationManager({required TranslationRepository repository})
      : _repository = repository;

  Future<TranslationEntry> translate(String word) async {
    return _repository.translate(word, TranslationLanguage.czech);
  }
}
