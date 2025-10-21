import 'package:auto_route/auto_route.dart';
import 'package:checkout/di/injection.dart';
import 'package:checkout/modules/cart/presentation/widgets/cart_button.dart';
import 'package:checkout/modules/product/presentation/bloc/product_list_bloc.dart';
import 'package:checkout/modules/product/presentation/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductListScreen extends StatelessWidget implements AutoRouteWrapper {
  const ProductListScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ProductListBloc>(
      create: (_) => getIt<ProductListBloc>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Kata'),
        actions: const [CartButton()],
      ),
      body: const SafeArea(
        child: ProductList(),
      ),
    );
  }
}
