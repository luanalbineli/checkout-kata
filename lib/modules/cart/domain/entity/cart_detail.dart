import 'package:checkout/modules/cart/domain/entity/cart_detail_item.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';

@immutable
class CartDetail {
  final Decimal grossAmount;
  final Decimal netAmount;
  final Decimal discountAmount;
  final List<CartDetailItem> items;

  int get itemCount => items.map((item) => item.quantity).sum;

  const CartDetail({
    required this.grossAmount,
    required this.netAmount,
    required this.discountAmount,
    required this.items,
  });
}
