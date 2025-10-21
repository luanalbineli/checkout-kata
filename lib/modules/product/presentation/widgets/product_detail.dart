import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:checkout/extensions/decimal_extensions.dart';
import 'package:checkout/modules/core/presentation/widgets/full_width.dart';
import 'package:checkout/modules/core/presentation/widgets/margin.dart';
import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:checkout/modules/product/domain/entity/product_display.dart';
import 'package:checkout/modules/product/domain/entity/promotion.dart';
import 'package:checkout/modules/product/domain/entity/promotion_display.dart';
import 'package:checkout/modules/product/presentation/bloc/product_detail_bloc.dart';
import 'package:checkout/modules/product/presentation/widgets/product_image.dart';
import 'package:checkout/modules/product/presentation/widgets/product_price.dart';
import 'package:checkout/modules/product/presentation/widgets/product_promotion_container.dart';
import 'package:checkout/modules/product/presentation/widgets/quantity_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetail extends StatelessWidget {
  final ProductDisplay productDisplay;

  const ProductDetail({super.key, required this.productDisplay});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalMargin(
          margin: context.mediaQuery.padding.top,
        ),
        _buildProductImageWithOverlay(context),
        Expanded(
          child: _buildProductDetail(context),
        )
      ],
    );
  }

  Widget _buildProductDetail(BuildContext context) {
    final ProductDisplay(:product) = productDisplay;

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
          const VerticalMargin(
            margin: AppDimens.defaultMargin05x,
          ),
          const Text(
            'Some fancy product description here. Eget nullam non nisi est sit amet facilisis magna etiam tempor orci eu lobortis elementum nibh',
          ),
          const Spacer(),
          _buildQuantityPicker(product),
          const VerticalMargin(),
          _buildAddProductCartButton(context, product),
        ],
      ),
    );
  }

  Widget _buildQuantityPicker(Product product) {
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
              const VerticalMargin(
                margin: AppDimens.defaultMargin025x,
              ),
              Text(
                'Total: ${state.total.formatWithCurrency}',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              const VerticalMargin(
                margin: AppDimens.defaultMargin05x,
              ),
              Text(
                '*Discounts are applied in the cart',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.theme.colorScheme.outline,
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

  Widget _buildProductImageWithOverlay(
    BuildContext context,
  ) =>
      Stack(
        children: [
          ProductImage(
            imageUrl: productDisplay.product.imageUrl,
            width: double.infinity,
            height: AppDimens.productDetailImageHeight,
            borderRadius: BorderRadius.zero,
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: 0.3,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child:
                _buildPromotionLabel(context, productDisplay.promotionDisplay),
          ),
        ],
      );

  Widget _buildAddProductCartButton(BuildContext context, Product product) {
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

  Widget _buildPromotionLabel(
    BuildContext context,
    PromotionDisplay? promotionDisplay,
  ) {
    if (promotionDisplay == null) {
      return const SizedBox.shrink();
    }

    final String promotionLabel;
    final PromotionDisplay(:promotion, :products) = promotionDisplay;
    switch (promotion) {
      case PromotionGetOneFree():
        promotionLabel = 'Buy ${promotion.quantity}, get 1 free';
      case PromotionMultipriced():
        promotionLabel =
            'Buy ${promotion.quantity} for ${promotion.price.formatWithCurrency}';
      case PromotionMealDeal():
        final labelList = promotion.skus.map((sku) {
          final product = products.firstWhere((product) => product.sku == sku);
          return '1 ${product.name}';
        }).join(' and ');
        promotionLabel =
            'Buy $labelList for ${promotion.price.formatWithCurrency}';
    }

    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(
          AppDimens.defaultMargin05x,
        ),
        child: ProductPromotionContainer(
          child: Text(
            promotionLabel,
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
