import 'package:auto_route/auto_route.dart';
import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/modules/core/presentation/widgets/margin.dart';
import 'package:checkout/modules/product/domain/entity/product_display.dart';
import 'package:checkout/modules/product/presentation/widgets/product_image.dart';
import 'package:checkout/modules/product/presentation/widgets/product_name.dart';
import 'package:checkout/modules/product/presentation/widgets/product_price.dart';
import 'package:checkout/modules/product/presentation/widgets/product_promotion_container.dart';
import 'package:checkout/router/app_router.gr.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductDisplay productDisplay;

  const ProductItem({
    super.key,
    required this.productDisplay,
  });

  @override
  Widget build(BuildContext context) {
    final ProductDisplay(:product) = productDisplay;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => _openProductDetail(context, productDisplay),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ProductImage(
                  imageUrl: product.imageUrl,
                  width: double.infinity,
                  borderRadius: BorderRadius.zero,
                ),
                if (productDisplay.promotionDisplay != null)
                  _buildPromotionBadge(context, productDisplay),
              ],
            ),
            const VerticalMargin(
              margin: AppDimens.defaultMargin05x,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.defaultMargin05x,
              ),
              child: ProductName(
                name: product.name,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(
                AppDimens.defaultMargin05x,
              ),
              child: Row(
                children: [
                  ProductPrice(price: product.price),
                  const Spacer(),
                  const Icon(
                    Icons.add_rounded,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openProductDetail(
    BuildContext context,
    ProductDisplay productDisplay,
  ) {
    context.router.push(ProductDetailRoute(productDisplay: productDisplay));
  }

  Widget _buildPromotionBadge(
    BuildContext context,
    ProductDisplay productDisplay,
  ) {
    return const Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.all(
            AppDimens.defaultMargin025x,
          ),
          child: ProductPromotionContainer(
            child: Icon(
              Icons.percent_outlined,
              size: AppDimens.productPromotionIconSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
