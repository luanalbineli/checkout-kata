part of 'cart_button_bloc.dart';

@immutable
sealed class CartButtonState {
  final int itemQuantity;

  const CartButtonState(this.itemQuantity);
}

final class CartButtonInitial extends CartButtonState {
  const CartButtonInitial() : super(0);
}

final class CartButtonUpdate extends CartButtonState {
  const CartButtonUpdate(super.itemQuantity);
}
