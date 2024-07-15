import 'package:checkout/modules/product/data/model/product_model.dart';
import 'package:meta/meta.dart';

@immutable
class Product {
  final String sku;
  final String? imageUrl;
  final String name;
  final double price;

  const Product({
    required this.sku,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'Product: $sku - $name - $price';
  }
}
