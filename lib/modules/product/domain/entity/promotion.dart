import 'package:meta/meta.dart';

@immutable
sealed class Promotion {}

class PromotionMultipriced extends Promotion {
  final String sku;
  final int quantity;
  final double price;

  PromotionMultipriced({
    required this.sku,
    required this.quantity,
    required this.price,
  });
}

class PromotionGetOneFree extends Promotion {
  final String sku;
  final int quantity;

  PromotionGetOneFree({
    required this.sku,
    required this.quantity,
  });
}

class PromotionMealDeal extends Promotion {
  final List<String> skus;
  final double price;

  PromotionMealDeal({
    required this.skus,
    required this.price,
  });
}
