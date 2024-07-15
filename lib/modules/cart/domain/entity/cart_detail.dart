import 'package:checkout/modules/cart/domain/entity/cart_detail_item.dart';
import 'package:meta/meta.dart';

@immutable
class CartDetail {
  final double grossAmount;
  final double netAmount;
  final double discountAmount;
  final List<CartDetailItem> items;

  const CartDetail({
    required this.grossAmount,
    required this.netAmount,
    required this.discountAmount,
    required this.items,
  });
}
