import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:checkout/modules/product/domain/entity/promotion.dart';

class PromotionDisplay {
  final List<Product> products;
  final Promotion promotion;

  PromotionDisplay(this.products, this.promotion);
}
