import 'package:checkout/modules/cart/domain/entity/cart_item.dart';
import 'package:checkout/modules/product/data/model/product_model.dart';
import 'package:meta/meta.dart';

@immutable
class CartItemModel {
  final ProductModel product;
  final int quantity;

  const CartItemModel(this.product, this.quantity);

  CartItem toEntity() => CartItem(
        product.toEntity(),
        quantity,
      );
}
