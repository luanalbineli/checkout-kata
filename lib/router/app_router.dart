import 'package:auto_route/auto_route.dart';
import 'package:checkout/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ProductListRoute.page, path: '/'),
        AutoRoute(page: ProductDetailRoute.page),
        AutoRoute(page: CartRoute.page),
      ];
}
