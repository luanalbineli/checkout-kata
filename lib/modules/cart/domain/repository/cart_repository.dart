import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:checkout/modules/cart/domain/entity/cart_item.dart';

abstract class CartRepository {
  Cart get();

  void update(Cart cart);
}
