import 'package:em_vocabulary/em_vocabulary.dart';
import 'package:get_it/get_it.dart';

Future<void> initVocabularyDependencies(GetIt getIt) async {
  final repository = VocabularyRepositoryImpl();
  await repository.initialize();

  getIt.registerSingleton<VocabularyRepository>(repository);
}
