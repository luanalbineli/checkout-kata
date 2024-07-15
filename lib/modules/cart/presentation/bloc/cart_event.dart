part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {
  const CartEvent();
}

class CartEventUpdate extends CartEvent {
  final Cart cart;

  const CartEventUpdate(this.cart);
}
