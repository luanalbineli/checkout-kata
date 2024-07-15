import 'package:auto_route/auto_route.dart';
import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/constants/app_images.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.defaultMargin),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: AppDimens.defaultMargin2x,
            ),
            Center(
              child: SvgPicture.asset(
                AppImages.illustrationEmpty,
                width: AppDimens.cartImageEmpty,
              ),
            ),
            const Spacer(),
            Text(
              'Your cart is empty',
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(
              height: AppDimens.defaultMargin05x,
            ),
            Text(
              'You should add at least one item in your cart',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: AppDimens.defaultMargin2x,
            ),
            ElevatedButton(
              onPressed: context.router.maybePop,
              child: const Text('Go shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
