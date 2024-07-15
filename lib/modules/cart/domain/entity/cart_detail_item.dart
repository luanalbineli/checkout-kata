import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:checkout/modules/product/domain/entity/promotion.dart';
import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';

@immutable
sealed class CartDetailItem {
  final int quantity;
  final Product product;
  final Decimal netTotal;

  const CartDetailItem({
    required this.product,
    required this.quantity,
    required this.netTotal,
  });

  Decimal get grossTotal => quantity.toDecimal() * product.price;
}

class CartDetailItemRegular extends CartDetailItem {
  CartDetailItemRegular({
    required super.product,
    required super.quantity,
  }) : super(
          netTotal: product.price * quantity.toDecimal(),
        );
}

class CartDetailItemPromotion extends CartDetailItem {
  final Promotion promotion;

  const CartDetailItemPromotion({
    required super.product,
    required super.quantity,
    required super.netTotal,
    required this.promotion,
  });
}
