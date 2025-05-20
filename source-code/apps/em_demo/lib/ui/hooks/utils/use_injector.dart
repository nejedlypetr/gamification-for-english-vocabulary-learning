import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

T useInjector<T extends Object>() {
  return useMemoized(() => GetIt.instance<T>());
}
