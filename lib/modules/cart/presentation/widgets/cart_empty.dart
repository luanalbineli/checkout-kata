import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plana_terra/constants/app_colors.dart';
import 'package:plana_terra/constants/app_dimens.dart';
import 'package:plana_terra/extensions/context_extensions.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconAssetPath;
  final Color? color;

  const EmptyState({
    required this.title,
    required this.subtitle,
    required this.iconAssetPath,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.defaultMargin),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: SvgPicture.asset(
                iconAssetPath,
                width: AppDimens.configurationPadlockIconWidth,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(
              height: AppDimens.defaultMargin05x,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: context.textTheme.subtitle2?.copyWith(
                color: AppColors.stormGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
