import 'package:checkout/constants/app_constants.dart';
import 'package:checkout/modules/product/domain/entity/promotion.dart';
import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';

abstract class PromotionRemoteDataSource {
  Future<List<Promotion>> getList();
}

@Injectable(as: PromotionRemoteDataSource)
class PromotionRemoteDataSourceImpl implements PromotionRemoteDataSource {
  @override
  Future<List<Promotion>> getList() {
    return Future.delayed(
      AppConstants.queryDuration,
      () => _promotionList,
    );
  }

  static final _promotionList = [
    PromotionMultipriced(
      skus: const ['B'],
      quantity: 2,
      price: Decimal.fromJson('1.25'),
    ),
    const PromotionGetOneFree(skus: ['C'], quantity: 3),
    PromotionMealDeal(
      skus: const ['D', 'E'],
      price: Decimal.fromJson('3.0'),
    ),
  ];
}
