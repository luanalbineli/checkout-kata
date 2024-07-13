part of 'cart_button_bloc.dart';

@immutable
sealed class CartButtonEvent {
  const CartButtonEvent();
}

class CartButtonEventUpdate extends CartButtonEvent {
  final Cart cart;

  const CartButtonEventUpdate(this.cart);
}
