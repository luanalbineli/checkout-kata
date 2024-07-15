import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:meta/meta.dart';

@immutable
final class ProductModel {
  final String sku;
  final String? imageUrl;
  final String name;
  final double price;

  const ProductModel({
    required this.sku,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  Product toEntity() => Product(
        sku: sku,
        name: name,
        price: price,
        imageUrl: imageUrl,
      );
}
