import 'package:checkout/modules/product/domain/entity/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem(this.product, this.quantity);
}
