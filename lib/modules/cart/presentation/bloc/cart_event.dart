part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {
  const CartEvent();
}

class CartEventUpdate extends CartEvent {
  final Cart cart;

  const CartEventUpdate(this.cart);
}

class CartEventUpdateItemQuantity extends CartEvent {
  final String productSku;
  final int quantity;

  const CartEventUpdateItemQuantity(this.productSku, this.quantity);
}

class CartEventDeleteItem extends CartEvent {
  final String productSku;

  const CartEventDeleteItem(this.productSku);
}
