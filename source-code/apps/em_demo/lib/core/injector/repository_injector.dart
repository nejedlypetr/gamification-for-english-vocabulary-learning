import 'package:english_mind_demo/data/repositories/flashcard_srs_metadata_repository_impl.dart';
import 'package:english_mind_demo/data/repositories/streak_repository_impl.dart';
import 'package:english_mind_demo/data/repositories/translation_repository_impl.dart';
import 'package:english_mind_demo/domain/repositories/flashcard_srs_metadata_repository.dart';
import 'package:english_mind_demo/domain/repositories/streak_repository.dart';
import 'package:english_mind_demo/domain/repositories/translation_repository.dart';
import 'package:get_it/get_it.dart';

void setupRepositoryInjector(GetIt injector) {
  injector.registerSingleton<FlashcardMetadataRepository>(
    FlashcardMetadataRepositoryMockImpl(),
  );
  injector.registerSingleton<TranslationRepository>(
    TranslationRepositoryMockImpl(),
  );
  injector.registerSingleton<StreakRepository>(
    StreakRepositoryObjectBoxImpl(streakBox: injector()),
  );
}
