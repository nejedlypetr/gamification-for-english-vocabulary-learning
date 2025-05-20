import 'package:english_mind_demo/ui/hooks/managers/managers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

bool useInitStudyManager() {
  final manager = useStudyManager();
  final isLoading = useState(true);

  useEffect(
    () {
      manager.init().then((_) {
        isLoading.value = false;
      });
      return null;
    },
    [],
  );

  return isLoading.value;
}
