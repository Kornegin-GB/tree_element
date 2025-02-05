import 'package:auto_route/auto_route.dart';
import 'package:tree_elements/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: TreeElementRoute.page, path: "/"),
      ];
}
