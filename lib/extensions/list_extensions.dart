import 'package:checkout/modules/product/domain/entity/promotion.dart';
import 'package:collection/collection.dart';

extension PromotionListExtension on Iterable<Promotion> {
  Promotion? getByProductSKU(String sku) => firstWhereOrNull(
        (promotion) => promotion.isForProduct(sku),
      );
}
