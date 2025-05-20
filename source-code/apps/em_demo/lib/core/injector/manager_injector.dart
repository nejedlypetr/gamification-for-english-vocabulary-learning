import 'package:english_mind_demo/domain/managers/streak_manager.dart';
import 'package:english_mind_demo/domain/managers/study_manager.dart';
import 'package:english_mind_demo/domain/managers/translation_manager.dart';
import 'package:get_it/get_it.dart';

void setupManagerInjector(GetIt injector) {
  injector.registerSingleton<StreakManager>(
    StreakManager(streakRepository: injector()),
  );
  injector.registerSingleton<StudyManager>(
    StudyManager(
      streakManager: injector(),
      vocabularyRepository: injector(),
      flashcardMetadataRepository: injector(),
    ),
  );
  injector.registerSingleton<TranslationManager>(
    TranslationManager(repository: injector()),
  );
}
