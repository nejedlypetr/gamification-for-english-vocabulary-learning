import 'package:em_vocabulary/em_vocabulary.dart';
import 'package:english_mind_demo/core/injector/manager_injector.dart';
import 'package:english_mind_demo/core/injector/object_box_injector.dart';
import 'package:english_mind_demo/core/injector/repository_injector.dart';
import 'package:get_it/get_it.dart';

final GetIt injector = GetIt.instance;

Future<void> initializeInjector() async {
  await initVocabularyDependencies(injector);
  await setupBoxInjector(injector);
  setupRepositoryInjector(injector);
  setupManagerInjector(injector);
}
