import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/home',
          page: HomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: '/study',
          page: StudyRoute.page,
        ),
      ];
}
