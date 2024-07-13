import 'package:auto_route/auto_route.dart';
import 'package:checkout/di/injection.dart';
import 'package:checkout/modules/cart/presentation/bloc/cart_button_bloc.dart';
import 'package:checkout/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartButtonBloc, CartButtonState>(
        bloc: getIt<CartButtonBloc>(),
        builder: (context, state) {
          return Badge(
            offset: const Offset(-8, 5),
            label: const SizedBox(
              width: 3,
            ),
            isLabelVisible: state.itemQuantity > 0,
            largeSize: 10,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                context.router.push(const CartRoute());
              },
              icon: const Icon(
                Icons.shopping_cart_rounded,
              ),
            ),
          );
        });
  }
}
