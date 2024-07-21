import 'package:checkout/extensions/list_extensions.dart';
import 'package:checkout/modules/core/domain/use_case/no_params.dart';
import 'package:checkout/modules/core/domain/use_case/use_case.dart';
import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:checkout/modules/product/domain/entity/product_display.dart';
import 'package:checkout/modules/product/domain/entity/promotion.dart';
import 'package:checkout/modules/product/domain/entity/promotion_display.dart';
import 'package:checkout/modules/product/domain/repository/product_repository.dart';
import 'package:checkout/modules/product/domain/repository/promotion_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductListUseCase
    extends AsyncUseCase<NoParams, List<ProductDisplay>> {
  final ProductRepository _productRepository;
  final PromotionRepository _promotionRepository;

  GetProductListUseCase(
    this._productRepository,
    this._promotionRepository,
  );

  @override
  Future<List<ProductDisplay>> execute(NoParams params) async {
    final products = await _productRepository.getList();
    final promotions = await _promotionRepository.getList();

    return products.map((product) {
      final promotion = promotions.getByProductSKU(product.sku);

      final promotionDisplay = _getPromotionDisplay(products, promotion);
      return ProductDisplay(product, promotionDisplay);
    }).toList(growable: false);
  }

  PromotionDisplay? _getPromotionDisplay(
    List<Product> products,
    Promotion? promotion,
  ) {
    if (promotion == null) {
      return null;
    }

    final promotionProducts = products
        .where(
          (product) => promotion.isForProduct(product.sku),
        )
        .toList(growable: false);

    return PromotionDisplay(promotionProducts, promotion);
  }
}
