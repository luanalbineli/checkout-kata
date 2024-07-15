import 'package:checkout/constants/app_dimens.dart';
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
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      AppDimens.productImageBorderRadius,
                    ),
                  )),
            ),
            const SizedBox(
              height: AppDimens.defaultMargin,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: (_numberOfRows * 2) - 1,
                  itemBuilder: (_, index) {
                    if (index.isEven) {
                      return Container(
                        width: double.infinity,
                        height: AppDimens.cartLoadingItemSize,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                AppDimens.productImageBorderRadius,
                              ),
                            )),
                      );
                    }

                    return const SizedBox(
                      height: AppDimens.defaultMargin,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  static const _numberOfRows = 5;
}
