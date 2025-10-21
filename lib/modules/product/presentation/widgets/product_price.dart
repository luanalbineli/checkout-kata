import 'package:checkout/constants/app_colors.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:checkout/extensions/decimal_extensions.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  final Decimal price;
  final TextStyle? priceTextStyle;

  const ProductPrice({
    super.key,
    required this.price,
    this.priceTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final text = RichText(
      text: TextSpan(
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 18,
          color: AppColors.text,
        ).merge(priceTextStyle),
        children: <TextSpan>[
          TextSpan(
            text: price.formatWithCurrency,
          ),
          TextSpan(
            text: ' each',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );

    return text;
  }
}
