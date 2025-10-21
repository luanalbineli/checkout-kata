import 'dart:math';

import 'package:checkout/extensions/list_extensions.dart';
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
      final promotion = promotions.getByProductSKU(cartItem.product.sku);

      final CartDetailItem cartDetailItem;
      if (promotion != null) {
        cartDetailItem =
            _processItemWithPromotion(cartItem, promotion, params.items);
      } else {
        cartDetailItem = _getCartDetailItemRegularFromCartItem(cartItem);
      }

      cartDetailItemList.add(cartDetailItem);
    }

    return CartDetail(
      cartDetailItemList,
    );
  }

  CartDetailItem _processItemWithPromotion(
    CartItem cartItem,
    Promotion promotion,
    List<CartItem> items,
  ) {
    switch (promotion) {
      case PromotionGetOneFree():
        return _processGetOneFreePromotion(cartItem, promotion);
      case PromotionMultipriced():
        return _processMultipricedPromotion(cartItem, promotion);
      case PromotionMealDeal():
        return _processMealDealPromotion(cartItem, promotion, items);
    }
  }

  CartDetailItem _processGetOneFreePromotion(
    CartItem cartItem,
    PromotionGetOneFree promotion,
  ) {
    final occurrences = (cartItem.quantity / (promotion.quantity + 1)).floor();
    if (occurrences == 0) {
      return _getCartDetailItemRegularFromCartItem(cartItem);
    }
    final netAmount =
        (cartItem.quantity - occurrences).toDecimal() * cartItem.product.price;

    return CartDetailItemPromotion(
      product: cartItem.product,
      quantity: cartItem.quantity,
      netTotal: netAmount,
      promotion: promotion,
    );
  }

  CartDetailItem _processMultipricedPromotion(
    CartItem cartItem,
    PromotionMultipriced promotion,
  ) {
    final occurrences = (cartItem.quantity / promotion.quantity).floor();
    if (occurrences == 0) {
      return _getCartDetailItemRegularFromCartItem(cartItem);
    }
    final occurrencesWithDiscountPrice =
        occurrences.toDecimal() * promotion.price;
    final remainingQuantity =
        cartItem.quantity - (occurrences * promotion.quantity);
    final netAmount = occurrencesWithDiscountPrice +
        remainingQuantity.toDecimal() * cartItem.product.price;

    return CartDetailItemPromotion(
      product: cartItem.product,
      quantity: cartItem.quantity,
      netTotal: netAmount,
      promotion: promotion,
    );
  }

  CartDetailItem _processMealDealPromotion(
    CartItem cartItem,
    PromotionMealDeal promotion,
    List<CartItem> items,
  ) {
    final skuDependency = promotion.skus.firstWhere(
      (sku) => sku != cartItem.product.sku,
    );
    final cartItemPromotionDependency = items.firstWhereOrNull(
      (cartItem) => cartItem.product.sku == skuDependency,
    );
    if (cartItemPromotionDependency == null) {
      return _getCartDetailItemRegularFromCartItem(cartItem);
    } else {
      final occurrences =
          min(cartItem.quantity, cartItemPromotionDependency.quantity)
              .toDecimal();
      final totalItemsWithDiscountedPrice =
          occurrences * (promotion.price / 2.toDecimal()).toDecimal();
      final totalItemsWithGrossPrice =
          (cartItem.quantity.toDecimal() - occurrences) *
              cartItem.product.price;
      final netTotal = totalItemsWithDiscountedPrice + totalItemsWithGrossPrice;

      return CartDetailItemPromotion(
          product: cartItem.product,
          quantity: cartItem.quantity,
          netTotal: netTotal,
          promotion: promotion);
    }
  }

  CartDetailItemRegular _getCartDetailItemRegularFromCartItem(
    CartItem item,
  ) =>
      CartDetailItemRegular(
        product: item.product,
        quantity: item.quantity,
      );
}
