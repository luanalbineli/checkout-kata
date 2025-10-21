import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:checkout/modules/cart/domain/use_case/get_cart_stream_use_case.dart';
import 'package:checkout/modules/core/domain/use_case/no_params.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'cart_button_event.dart';
part 'cart_button_state.dart';

@injectable
class CartButtonBloc extends Bloc<CartButtonEvent, CartButtonState> {
  final GetCartStreamUseCase _getCartStreamUseCase;
  StreamSubscription<Cart>? _cartSubscription;

  CartButtonBloc(this._getCartStreamUseCase)
      : super(const CartButtonInitial()) {
    on<CartButtonEventUpdate>(_updateCartItemCount);

    _cartSubscription =
        _getCartStreamUseCase.call(NoParams.instance).data?.listen(
      (cart) {
        add(CartButtonEventUpdate(cart));
      },
    );
  }

  void _updateCartItemCount(
    CartButtonEventUpdate event,
    Emitter<CartButtonState> emit,
  ) {
    final itemCount = event.cart.items.map((item) => item.quantity).sum;

    emit(
      CartButtonUpdate(itemCount),
    );
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}
