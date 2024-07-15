import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:checkout/modules/cart/domain/entity/cart_detail.dart';
import 'package:checkout/modules/core/domain/use_case/use_case.dart';
import 'package:checkout/modules/product/domain/repository/promotion_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartDetailUseCase extends AsyncUseCase<Cart, CartDetail> {
  final PromotionRepository _promotionRepository;

  GetCartDetailUseCase(this._promotionRepository);

  @override
  Future<CartDetail> execute(Cart params) async {
    final promotions = await _promotionRepository.getList();

    return const CartDetail(
      grossAmount: 10,
      netAmount: 8,
      discountAmount: 2,
      items: [],
    );
  }
}
