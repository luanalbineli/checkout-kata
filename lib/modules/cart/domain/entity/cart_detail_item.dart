import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:checkout/modules/product/domain/entity/promotion.dart';
import 'package:meta/meta.dart';

@immutable
sealed class CartDetailItem {
  const CartDetailItem();
}

class CartDetailItemRegular extends CartDetailItem {
  final int quantity;
  final Product product;
  final double total;

  const CartDetailItemRegular(this.quantity, this.product, this.total);
}

class CartDetailItemPromotion extends CartDetailItem {
  final int quantity;
  final Product product;
  final double grossAmount;
  final double netAmount;
  final Promotion promotion;

  const CartDetailItemPromotion(
    this.quantity,
    this.product,
    this.grossAmount,
    this.netAmount,
    this.promotion,
  );
}
