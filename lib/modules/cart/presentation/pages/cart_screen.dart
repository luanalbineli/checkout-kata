import 'package:auto_route/auto_route.dart';
import 'package:checkout/di/injection.dart';
import 'package:checkout/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:checkout/modules/cart/presentation/widgets/cart_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CartScreen extends StatelessWidget implements AutoRouteWrapper {
  const CartScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (_) => getIt<CartBloc>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: SafeArea(
        child: const CartDetail(),
      ),
    );
  }
}
