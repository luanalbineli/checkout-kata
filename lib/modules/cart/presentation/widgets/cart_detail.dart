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
import 'package:checkout/modules/core/presentation/widgets/full_width.dart';
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
          _buildCartTotals(context, state.cartDetail),
          const VerticalMargin(),
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  Widget _buildCartItemList(List<CartDetailItem> items) {
    return ListView.separated(
      separatorBuilder: (_, __) => const VerticalMargin(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final cartItem = items[index];
        return IntrinsicHeight(
          child: Row(
            children: [
              ProductImage(
                imageUrl: cartItem.product.imageUrl,
              ),
              const HorizontalMargin(
                margin: AppDimens.defaultMargin05x,
              ),
              Expanded(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ProductName(
                            name: cartItem.product.name,
                          ),
                        ),
                        const HorizontalMargin(
                          margin: AppDimens.defaultMargin,
                        ),
                        SizedBox(
                          width: AppDimens.cartDeleteButtonSize,
                          height: AppDimens.cartDeleteButtonSize,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              BlocProvider.of<CartBloc>(context).add(
                                CartEventDeleteItem(
                                  cartItem.product.sku,
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete_rounded),
                          ),
                        )
                      ],
                    ),
                    const VerticalMargin(),
                    Row(
                      children: [
                        Text(cartItem.netTotal.formatWithCurrency),
                        if (cartItem.netTotal != cartItem.grossTotal)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: AppDimens.defaultMargin05x,
                            ),
                            child: Text(
                              cartItem.grossTotal.formatWithCurrency,
                              style: TextStyle(
                                color: context.theme.colorScheme.outline,
                                decoration: TextDecoration.lineThrough,
                                decorationColor:
                                    context.theme.colorScheme.outline,
                              ),
                            ),
                          ),
                        const Spacer(),
                        QuantityPicker(
                          quantity: cartItem.quantity,
                          inputWidth: AppDimens.quantityPickerInputWidth * 0.5,
                          onPressed: (quantity) {
                            BlocProvider.of<CartBloc>(context).add(
                              CartEventUpdateItemQuantity(
                                cartItem.product.sku,
                                quantity,
                              ),
                            );
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

  Widget _buildCartTotals(
    BuildContext context,
    entity.CartDetail cartDetail,
  ) {
    final totalTextStyle = context.textTheme.titleMedium;
    return Column(
      children: [
        Row(
          children: [
            const Text('Subtotal'),
            const Spacer(),
            Text(cartDetail.grossTotal.formatWithCurrency),
          ],
        ),
        const VerticalMargin(
          margin: AppDimens.defaultMargin025x,
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
            Text(
              'Total',
              style: totalTextStyle,
            ),
            const Spacer(),
            Text(
              cartDetail.netTotal.formatWithCurrency,
              style: totalTextStyle,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildCheckoutButton() => FullWidth(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Checkout'),
        ),
      );
}
