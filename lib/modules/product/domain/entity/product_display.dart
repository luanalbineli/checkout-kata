import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:checkout/modules/product/domain/entity/promotion_display.dart';
import 'package:meta/meta.dart';

@immutable
class ProductDisplay {
  final Product product;
  final PromotionDisplay? promotionDisplay;

  const ProductDisplay(this.product, this.promotionDisplay);
}
