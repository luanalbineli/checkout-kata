import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';

@immutable
sealed class Promotion {
  const Promotion();

  bool isForProduct(String sku);
}

final class PromotionMultipriced extends Promotion {
  final String sku;
  final int quantity;
  final Decimal price;

  const PromotionMultipriced({
    required this.sku,
    required this.quantity,
    required this.price,
  });

  @override
  bool isForProduct(String sku) => sku == this.sku;
}

final class PromotionGetOneFree extends Promotion {
  final String sku;
  final int quantity;

  const PromotionGetOneFree({
    required this.sku,
    required this.quantity,
  });

  @override
  bool isForProduct(String sku) => this.sku == sku;
}

final class PromotionMealDeal extends Promotion {
  final Decimal price;
  final List<String> skus;

  const PromotionMealDeal({
    required this.skus,
    required this.price,
  });

  @override
  bool isForProduct(String sku) => skus.contains(sku);
}
