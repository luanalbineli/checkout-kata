import 'package:checkout/modules/cart/data/model/cart_item_model.dart';
import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:meta/meta.dart';

@immutable
final class CartModel {
  final List<CartItemModel> items;

  const CartModel(this.items);

  CartModel.empty() : items = [];

  Cart toEntity() => Cart(
        items.map((item) => item.toEntity()).toList(),
      );
}
