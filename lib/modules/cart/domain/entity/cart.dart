import 'package:checkout/modules/cart/domain/entity/cart_item.dart';
import 'package:meta/meta.dart';

@immutable
final class Cart {
  final List<CartItem> items;

  const Cart(this.items);
}
