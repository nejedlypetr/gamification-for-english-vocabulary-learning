import 'package:english_mind_demo/data/datasources/local/streak_box.dart';
import 'package:english_mind_demo/objectbox.g.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final directory = p.join(docsDir.path, 'obx_em');
    Store? store;
    if (Store.isOpen(directory)) {
      store = Store.attach(getObjectBoxModel(), directory);
    } else {
      store = await openStore(directory: directory);
    }
    return ObjectBox._create(store);
  }
}

Future<void> setupBoxInjector(GetIt injector) async {
  final objectbox = await ObjectBox.create();

  final streakBox = objectbox.store.box<StreakObjectBox>();

  injector.registerSingleton<ObjectBox>(objectbox);
  injector.registerSingleton<Box<StreakObjectBox>>(streakBox);
}
