import 'package:english_mind_demo/domain/managers/streak_manager.dart';
import 'package:english_mind_demo/domain/managers/study_manager.dart';
import 'package:english_mind_demo/domain/managers/translation_manager.dart';
import 'package:english_mind_demo/ui/hooks/utils/use_injector.dart';

StreakManager useStreakManager() {
  return useInjector<StreakManager>();
}

StudyManager useStudyManager() {
  return useInjector<StudyManager>();
}

TranslationManager useTranslationManager() {
  return useInjector<TranslationManager>();
}
