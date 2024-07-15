import 'package:checkout/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ProductName extends StatelessWidget {
  final String name;

  const ProductName({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
