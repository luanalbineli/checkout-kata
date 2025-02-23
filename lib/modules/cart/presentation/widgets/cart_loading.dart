import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/modules/core/presentation/widgets/margin.dart';
import 'package:checkout/modules/core/presentation/widgets/skeleton_effect.dart';
import 'package:flutter/material.dart';

class CartLoading extends StatelessWidget {
  const CartLoading({super.key});

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
              child: ListView.separated(
                separatorBuilder: (_, __) => const VerticalMargin(),
                itemCount: _numberOfRows,
                itemBuilder: (_, index) => Container(
                  height: AppDimens.cartLoadingItemSize,
                  decoration: SkeletonEffect.containerBoxDecoration,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static const _numberOfRows = 4;
}
