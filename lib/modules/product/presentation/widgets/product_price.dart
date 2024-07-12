import 'package:checkout/constants/app_colors.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  final double price;

  const ProductPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    var text = RichText(
      text: TextSpan(
        style: context.textTheme.labelSmall
            ?.copyWith(color: AppColors.textDarkGray),
        children: <TextSpan>[
          TextSpan(
            text: '£${price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14,
              color: AppColors.text,
            ),
          ),
          const TextSpan(
            text: ' each',
          ),
        ],
      ),
    );

    return text;
  }
}
