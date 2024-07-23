import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ProductPromotionContainer extends StatelessWidget {
  final Widget child;

  const ProductPromotionContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimens.productImageBorderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          AppDimens.defaultMargin025x,
        ),
        child: child,
      ),
    );
  }
}
