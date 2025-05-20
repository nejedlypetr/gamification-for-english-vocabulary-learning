import 'package:em_vocabulary/em_vocabulary.dart';

abstract class VocabularyRepository {
  Future<void> initialize();
  Future<VocabularyEntry?> getVocabularyEntry(int fid);
  Future<List<VocabularyEntry>> getAllVocabularyEntries();
  Future<List<VocabularyEntry>> getVocabularyEntries(List<int> ids);
}
