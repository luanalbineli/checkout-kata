part of 'cart_bloc.dart';

@immutable
sealed class CartState {
  const CartState();
}

final class CartStateEmpty extends CartState {
  const CartStateEmpty();
}

final class CartStateLoading extends CartState {
  const CartStateLoading();
}

final class CartStateShowDetail extends CartState {
  final CartDetail cartDetail;

  const CartStateShowDetail(this.cartDetail);
}

final class CartStateError extends CartState {
  const CartStateError();
}
