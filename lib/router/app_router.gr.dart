// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:checkout/modules/cart/presentation/pages/cart_screen.dart'
    as _i1;
import 'package:checkout/modules/product/domain/entity/product.dart' as _i6;
import 'package:checkout/modules/product/presentation/pages/product_detail_screen.dart'
    as _i2;
import 'package:checkout/modules/product/presentation/pages/product_list_screen.dart'
    as _i3;
import 'package:flutter/material.dart' as _i5;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    CartRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CartScreen(),
      );
    },
    ProductDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailRouteArgs>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ProductDetailScreen(
          key: args.key,
          product: args.product,
        ),
      );
    },
    ProductListRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ProductListScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CartScreen]
class CartRoute extends _i4.PageRouteInfo<void> {
  const CartRoute({List<_i4.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ProductDetailScreen]
class ProductDetailRoute extends _i4.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    _i5.Key? key,
    required _i6.Product product,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          ProductDetailRoute.name,
          args: ProductDetailRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailRoute';

  static const _i4.PageInfo<ProductDetailRouteArgs> page =
      _i4.PageInfo<ProductDetailRouteArgs>(name);
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({
    this.key,
    required this.product,
  });

  final _i5.Key? key;

  final _i6.Product product;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i3.ProductListScreen]
class ProductListRoute extends _i4.PageRouteInfo<void> {
  const ProductListRoute({List<_i4.PageRouteInfo>? children})
      : super(
          ProductListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductListRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
