import 'package:meta/meta.dart';

@immutable
sealed class Promotion {
  final List<String> skus;

  const Promotion({required this.skus});
}

final class PromotionMultipriced extends Promotion {
  final int quantity;
  final double price;

  const PromotionMultipriced({
    required super.skus,
    required this.quantity,
    required this.price,
  });
}

final class PromotionGetOneFree extends Promotion {
  final int quantity;

  const PromotionGetOneFree({
    required super.skus,
    required this.quantity,
  });
}

final class PromotionMealDeal extends Promotion {
  final double price;

  const PromotionMealDeal({
    required super.skus,
    required this.price,
  });
}
