// dart format width=80
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
import 'package:checkout/modules/product/domain/entity/product_display.dart'
    as _i6;
import 'package:checkout/modules/product/presentation/pages/product_detail_screen.dart'
    as _i2;
import 'package:checkout/modules/product/presentation/pages/product_list_screen.dart'
    as _i3;
import 'package:flutter/material.dart' as _i5;

/// generated route for
/// [_i1.CartScreen]
class CartRoute extends _i4.PageRouteInfo<void> {
  const CartRoute({List<_i4.PageRouteInfo>? children})
      : super(CartRoute.name, initialChildren: children);

  static const String name = 'CartRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return _i4.WrappedRoute(child: const _i1.CartScreen());
    },
  );
}

/// generated route for
/// [_i2.ProductDetailScreen]
class ProductDetailRoute extends _i4.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    _i5.Key? key,
    required _i6.ProductDisplay productDisplay,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          ProductDetailRoute.name,
          args:
              ProductDetailRouteArgs(key: key, productDisplay: productDisplay),
          initialChildren: children,
        );

  static const String name = 'ProductDetailRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailRouteArgs>();
      return _i4.WrappedRoute(
        child: _i2.ProductDetailScreen(
          key: args.key,
          productDisplay: args.productDisplay,
        ),
      );
    },
  );
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({this.key, required this.productDisplay});

  final _i5.Key? key;

  final _i6.ProductDisplay productDisplay;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, productDisplay: $productDisplay}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProductDetailRouteArgs) return false;
    return key == other.key && productDisplay == other.productDisplay;
  }

  @override
  int get hashCode => key.hashCode ^ productDisplay.hashCode;
}

/// generated route for
/// [_i3.ProductListScreen]
class ProductListRoute extends _i4.PageRouteInfo<void> {
  const ProductListRoute({List<_i4.PageRouteInfo>? children})
      : super(ProductListRoute.name, initialChildren: children);

  static const String name = 'ProductListRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return _i4.WrappedRoute(child: const _i3.ProductListScreen());
    },
  );
}
