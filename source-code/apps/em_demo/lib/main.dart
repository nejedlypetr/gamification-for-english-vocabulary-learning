import 'package:em_theme/em_theme.dart';
import 'package:english_mind_demo/core/injector/injector.dart';
import 'package:english_mind_demo/core/l10n/app_localizations.g.dart';
import 'package:english_mind_demo/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await initializeInjector();

  final appRouter = AppRouter();
  runApp(App(appRouter: appRouter));
}

class App extends StatelessWidget {
  final AppRouter appRouter;

  const App({required this.appRouter, super.key});

  @override
  Widget build(BuildContext context) {
    return AppThemeProvider(
      theme: AppTheme(AppThemeMode.light),
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
        debugShowCheckedModeBanner: false,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
      ),
    );
  }
}
