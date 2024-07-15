import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class Product extends Equatable {
  final String sku;
  final String? imageUrl;
  final String name;
  final Decimal price;

  const Product({
    required this.sku,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [sku];

  @override
  String toString() {
    return 'Product: $sku - $name - $price';
  }
}
