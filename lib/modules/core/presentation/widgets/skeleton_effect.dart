import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonEffect extends StatelessWidget {
  final Widget child;

  const SkeletonEffect({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.theme.colorScheme.outlineVariant,
      highlightColor: Colors.white,
      child: child,
    );
  }

  static const containerBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(
        AppDimens.skeletonEffectContainerBorderRadius,
      ),
    ),
  );
}
