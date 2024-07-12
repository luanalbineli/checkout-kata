import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:checkout/extensions/double_extensions.dart';
import 'package:checkout/modules/core/presentation/widgets/full_width.dart';
import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:checkout/modules/product/presentation/bloc/product_detail_bloc.dart';
import 'package:checkout/modules/product/presentation/widgets/product_image.dart';
import 'package:checkout/modules/product/presentation/widgets/product_price.dart';
import 'package:checkout/modules/product/presentation/widgets/quantity_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: context.mediaQuery.padding.top,
        ),
        _buildProductImageWithOverlay(),
        Expanded(
          child: _buildProductDetail(context),
        )
      ],
    );
  }

  Widget _buildProductDetail(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: AppDimens.defaultMargin05x,
          ),
          const Text(
            'Some fancy product description here. Eget nullam non nisi est sit amet facilisis magna etiam tempor orci eu lobortis elementum nibh',
          ),
          const Spacer(),
          _buildQuantityPicker(),
          const SizedBox(
            height: AppDimens.defaultMargin,
          ),
          _buildAddProductCartButton(context),
        ],
      ),
    );
  }

  Widget _buildQuantityPicker() {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductPrice(
                price: product.price,
                priceTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: AppDimens.defaultMargin05x,
              ),
              Text(
                'Total: ${state.total.formatWithCurrency}',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Spacer(),
          QuantityPicker(
            quantity: state.quantity,
            onPressed: (quantity) {
              BlocProvider.of<ProductDetailBloc>(context).add(
                ProductDetailEventUpdateQuantity(product, quantity),
              );
            },
          ),
        ],
      );
    });
    //
  }

  Widget _buildProductImageWithOverlay() => Stack(
        children: [
          ProductImage(
            imageUrl: product.imageUrl,
            width: double.infinity,
            height: AppDimens.productDetailImageHeight,
            borderRadius: BorderRadius.zero,
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
        ],
      );

  Widget _buildAddProductCartButton(BuildContext context) {
    return FullWidth(
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<ProductDetailBloc>(context).add(
            ProductDetailEventAddCart(product),
          );
        },
        child: const Text('Add to cart'),
      ),
    );
  }
}
