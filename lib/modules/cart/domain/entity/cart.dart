import 'package:checkout/modules/cart/domain/entity/cart_item.dart';
import 'package:meta/meta.dart';

@immutable
class Cart {
  final List<CartItem> items;

  const Cart(this.items);

  Cart.empty() : items = [];
}
