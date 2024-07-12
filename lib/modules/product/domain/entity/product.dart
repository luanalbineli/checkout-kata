class Product {
  final String sku;
  final String? imageUrl;
  final String description;
  final double price;

  const Product({
    required this.sku,
    required this.description,
    required this.price,
    this.imageUrl,
  });
}
