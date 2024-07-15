import 'package:checkout/constants/app_dimens.dart';
import 'package:flutter/material.dart';

class VerticalMargin extends StatelessWidget {
  final double margin;

  const VerticalMargin({
    super.key,
    this.margin = AppDimens.defaultMargin,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: margin,
      );
}

class HorizontalMargin extends StatelessWidget {
  final double margin;

  const HorizontalMargin({
    super.key,
    this.margin = AppDimens.defaultMargin,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: margin,
      );
}
