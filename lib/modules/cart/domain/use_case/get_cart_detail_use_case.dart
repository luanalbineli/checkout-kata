import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:checkout/modules/cart/domain/entity/cart_detail.dart';
import 'package:checkout/modules/cart/domain/entity/cart_detail_item.dart';
import 'package:checkout/modules/cart/domain/entity/cart_item.dart';
import 'package:checkout/modules/core/domain/use_case/use_case.dart';
import 'package:checkout/modules/product/domain/entity/promotion.dart';
import 'package:checkout/modules/product/domain/repository/promotion_repository.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartDetailUseCase extends AsyncUseCase<Cart, CartDetail> {
  final PromotionRepository _promotionRepository;

  GetCartDetailUseCase(this._promotionRepository);

  @override
  Future<CartDetail> execute(Cart params) async {
    final promotions = await _promotionRepository.getList();

    final List<CartDetailItem> cartDetailItemList = [];
    for (final cartItem in params.items) {
      final promotion = promotions.firstWhereOrNull(
        (promotion) => promotion.skus.contains(cartItem.product.sku),
      );

      if (promotion != null) {
        final cartDetailItem =
            _processItemWithPromotion(cartItem, promotion, params.items);
        if (cartDetailItem != null) {
          cartDetailItemList.add(cartDetailItem);
        }
      } else {
        cartDetailItemList.add(CartDetailItemRegular(
          product: cartItem.product,
          quantity: cartItem.quantity,
        ));
      }
    }

    return CartDetail(
      grossAmount: 10.toDecimal(),
      netAmount: 8.toDecimal(),
      discountAmount: 2.toDecimal(),
      items: cartDetailItemList,
    );
  }

  CartDetailItem? _processItemWithPromotion(
    CartItem cartItem,
    Promotion promotion,
    List<CartItem> items,
  ) {
    if (promotion is PromotionGetOneFree) {
      final occurrences = (cartItem.quantity / promotion.quantity).floor();
      final netAmount = (cartItem.quantity - occurrences).toDecimal() *
          cartItem.product.price;

      return CartDetailItemPromotion(
        product: cartItem.product,
        quantity: cartItem.quantity,
        netAmount: netAmount,
        promotion: promotion,
      );
    }

    return null;
  }
}
