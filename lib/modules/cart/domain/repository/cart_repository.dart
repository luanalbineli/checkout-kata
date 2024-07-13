import 'package:checkout/modules/cart/domain/entity/cart.dart';

abstract class CartRepository {
  Cart get();

  Stream<Cart> getStream();

  void update(Cart cart);
}
