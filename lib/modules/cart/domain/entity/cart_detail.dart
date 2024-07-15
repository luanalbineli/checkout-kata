import 'package:checkout/extensions/decimal_extensions.dart';
import 'package:checkout/modules/cart/domain/entity/cart_detail_item.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';

@immutable
class CartDetail {
  final List<CartDetailItem> items;

  int get itemCount => items.map((item) => item.quantity).sum;

  Decimal get grossTotal => items.map((item) => item.grossTotal).sum;

  Decimal get netTotal => items.map((item) => item.netTotal).sum;

  Decimal get discountTotal => grossTotal - netTotal;

  const CartDetail(
    this.items,
  );
}
