import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/modules/core/presentation/widgets/margin.dart';
import 'package:checkout/modules/core/presentation/widgets/skeleton_effect.dart';
import 'package:flutter/material.dart';

class ProductLoading extends StatelessWidget {
  const ProductLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonEffect(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AppDimens.cartLoadingItemSize,
              height: AppDimens.cartLoadingItemSize / 3,
              decoration: SkeletonEffect.containerBoxDecoration,
            ),
            const VerticalMargin(),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppDimens.defaultMargin,
                    crossAxisSpacing: AppDimens.defaultMargin,
                  ),
                  itemCount: _numberOfItems,
                  itemBuilder: (_, index) {
                    return Container(
                      decoration: SkeletonEffect.containerBoxDecoration,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  static const _numberOfItems = 6;
}
