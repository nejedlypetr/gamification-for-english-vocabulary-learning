import 'package:english_mind_demo/data/models/translation_entry.dart';
import 'package:english_mind_demo/ui/hooks/managers/managers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

(bool, TranslationEntry?) useTranslation(String word) {
  final translationManager = useTranslationManager();
  final isLoading = useState(true);
  final translation = useRef<TranslationEntry?>(null);

  useEffect(
    () {
      Future.microtask(() async {
        final result = await translationManager.translate(word);
        translation.value = result;
        isLoading.value = false;
      });
      return null;
    },
    [word],
  );

  return (isLoading.value, translation.value);
}
