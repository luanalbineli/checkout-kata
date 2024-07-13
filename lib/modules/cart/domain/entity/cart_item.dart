import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:meta/meta.dart';

@immutable
class CartItem {
  final Product product;
  final int quantity;

  const CartItem(this.product, this.quantity);
}
