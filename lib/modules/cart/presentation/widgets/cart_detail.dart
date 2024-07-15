import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:checkout/extensions/decimal_extensions.dart';
import 'package:checkout/extensions/text_theme_extensions.dart';
import 'package:checkout/modules/cart/domain/entity/cart_detail.dart' as entity;
import 'package:checkout/modules/cart/domain/entity/cart_detail_item.dart';
import 'package:checkout/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:checkout/modules/cart/presentation/widgets/cart_empty.dart';
import 'package:checkout/modules/cart/presentation/widgets/cart_error.dart';
import 'package:checkout/modules/cart/presentation/widgets/cart_loading.dart';
import 'package:checkout/modules/core/presentation/widgets/margin.dart';
import 'package:checkout/modules/product/presentation/widgets/product_image.dart';
import 'package:checkout/modules/product/presentation/widgets/product_name.dart';
import 'package:checkout/modules/product/presentation/widgets/quantity_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartDetail extends StatelessWidget {
  const CartDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartStateEmpty) {
          return const CartEmpty();
        }

        if (state is CartStateError) {
          return const CartError();
        }

        if (state is CartStateShowDetail) {
          return _buildCartDetail(context, state);
        }

        return const CartLoading();
      },
    );
  }

  Widget _buildCartDetail(BuildContext context, CartStateShowDetail state) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Items (${state.cartDetail.itemCount}):',
            style: context.textTheme.screenTitle,
          ),
          const VerticalMargin(),
          Expanded(
            child: _buildCartItemList(state.cartDetail.items),
          ),
          const VerticalMargin(),
          _buildCartTotals(state.cartDetail),
          const VerticalMargin(),
        ],
      ),
    );
  }

  Widget _buildCartItemList(List<CartDetailItem> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final cartItem = items[index];
        return IntrinsicHeight(
          child: Row(
            children: [
              ProductImage(
                imageUrl: cartItem.product.imageUrl,
              ),
              const HorizontalMargin(),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ProductName(
                          name: cartItem.product.name,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // TODO: Implement delete item.
                          },
                          icon: const Icon(Icons.delete_rounded),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(cartItem.grossTotal.formatWithCurrency),
                        const Spacer(),
                        QuantityPicker(
                          quantity: cartItem.quantity,
                          onPressed: (quantity) {
                            // TODO: Update quantity.
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartTotals(entity.CartDetail cartDetail) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Subtotal'),
            const Spacer(),
            Text(cartDetail.grossTotal.formatWithCurrency),
          ],
        ),
        Row(
          children: [
            const Text('Discount'),
            const Spacer(),
            Text(cartDetail.discountTotal.formatWithCurrency),
          ],
        ),
        const VerticalMargin(),
        Row(
          children: [
            const Text('Total'),
            const Spacer(),
            Text(cartDetail.netTotal.formatWithCurrency),
          ],
        )
      ],
    );
  }
}
