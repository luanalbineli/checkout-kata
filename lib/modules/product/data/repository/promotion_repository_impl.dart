import 'package:checkout/modules/core/domain/repository/cached_repository.dart';
import 'package:checkout/modules/product/data/data_source/promotion_remote_data_source.dart';
import 'package:checkout/modules/product/domain/entity/promotion.dart';
import 'package:checkout/modules/product/domain/repository/promotion_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PromotionRepository)
class PromotionRepositoryImpl
    with CachedRepository
    implements PromotionRepository {
  final PromotionRemoteDataSource _promotionRemoteDataSource;

  PromotionRepositoryImpl(this._promotionRemoteDataSource);

  @override
  Future<List<Promotion>> getList() => getFromCache(
        _promotionListCacheKey,
        CachedRepository.durationDefault,
        () => _promotionRemoteDataSource.getList(),
      );

  static const String _promotionListCacheKey = 'promotion_list_cache';
}
