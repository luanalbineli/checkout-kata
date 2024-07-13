import 'package:checkout/modules/product/domain/entity/promotion.dart';

abstract class PromotionRepository {
  Future<List<Promotion>> getList();
}
