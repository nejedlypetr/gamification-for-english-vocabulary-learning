import 'package:english_mind_demo/data/models/flashcard_srs_metadata.dart';

abstract class FlashcardMetadataRepository {
  Future<List<FlashcardSrsMetadata>> getDueNowFlashcardMetadataList();
}
