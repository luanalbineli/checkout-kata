import 'package:checkout/modules/product/data/data_source/promotion_remote_data_source.dart';
import 'package:checkout/modules/product/domain/entity/promotion.dart';
import 'package:checkout/modules/product/domain/repository/promotion_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PromotionRepository)
class PromotionRepositoryImpl implements PromotionRepository {
  final PromotionRemoteDataSource _promotionRemoteDataSource;

  PromotionRepositoryImpl(this._promotionRemoteDataSource);

  @override
  Future<List<Promotion>> getList() => _promotionRemoteDataSource.getList();
}
