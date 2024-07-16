import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/constants/app_images.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.defaultMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.illustrationError,
            width: AppDimens.cartErrorImageWidth,
          ),
          const SizedBox(height: AppDimens.defaultMargin2x),
          Text(
            'Oooops!',
            style: context.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.defaultMargin05x),
          Text(
            'Something went wrong, but we are already working to solve it',
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
