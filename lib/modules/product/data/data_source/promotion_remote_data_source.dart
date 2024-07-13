import 'package:checkout/constants/app_constants.dart';
import 'package:checkout/modules/product/domain/entity/promotion.dart';
import 'package:injectable/injectable.dart';

abstract class PromotionRemoteDataSource {
  Future<List<Promotion>> getList();
}

@Injectable(as: PromotionRemoteDataSource)
class PromotionRemoteDataSourceImpl implements PromotionRemoteDataSource {
  @override
  Future<List<Promotion>> getList() => Future.delayed(
        AppConstants.queryDuration,
        () => _promotionList,
      );

  static final _promotionList = [
    PromotionMultipriced(sku: 'B', quantity: 2, price: 1.25),
    PromotionGetOneFree(sku: 'C', quantity: 3),
    PromotionMealDeal(skus: const ['D', 'E'], price: 3.0),
  ];
}
