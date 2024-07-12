import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String sku;
  final String? imageUrl;
  final String name;
  final double price;

  const Product({
    required this.sku,
    required this.name,
    required this.price,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [sku];
}
