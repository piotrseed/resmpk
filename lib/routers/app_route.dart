import 'package:auto_route/auto_route.dart';
import 'package:resmpk/routers/app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: DetailsRoute.page),
        AutoRoute(page: HomeRoute.page, initial: true),
      ];
}
