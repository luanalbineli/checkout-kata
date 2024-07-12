import 'package:cached_network_image/cached_network_image.dart';
import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const ProductImage({
    this.imageUrl,
    this.width = AppDimens.productImageSize,
    this.height = AppDimens.productImageSize,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(
        AppDimens.productImageBorderRadius,
      ),
    ),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return _buildImagePlaceholder(context);
    }

    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageUrl!,
      width: width,
      height: height,
      placeholder: (context, __) => _buildImagePlaceholder(context),
      errorWidget: (context, _, __) => _buildImagePlaceholder(context),
      imageBuilder: (context, imageProvider) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.outlineVariant,
        borderRadius: borderRadius,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Icon(
          Icons.image_rounded,
          color: context.theme.colorScheme.outline,
        ),
      ),
    );
  }
}
