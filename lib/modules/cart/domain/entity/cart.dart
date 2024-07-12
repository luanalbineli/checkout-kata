import 'package:checkout/modules/cart/domain/entity/cart_item.dart';

class Cart {
  final List<CartItem> items;

  Cart(this.items);

  Cart.empty() : items = [];
}
