import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:checkout/modules/cart/domain/entity/cart_detail.dart';
import 'package:checkout/modules/cart/domain/use_case/get_cart_detail_use_case.dart';
import 'package:checkout/modules/cart/domain/use_case/get_cart_stream_use_case.dart';
import 'package:checkout/modules/core/domain/use_case/no_params.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartStreamUseCase _getCartStreamUseCase;
  final GetCartDetailUseCase _getCartDetailUseCase;
  StreamSubscription<Cart>? _cartSubscription;

  CartBloc(
    this._getCartStreamUseCase,
    this._getCartDetailUseCase,
  ) : super(const CartStateLoading()) {
    on<CartEventUpdate>(_updateCartDetail);

    _cartSubscription =
        _getCartStreamUseCase.call(NoParams.instance).data?.listen(
      (cart) {
        add(CartEventUpdate(cart));
      },
    );
  }

  FutureOr<void> _updateCartDetail(
    CartEventUpdate event,
    Emitter<CartState> emit,
  ) async {
    if (event.cart.items.isEmpty) {
      emit(const CartStateEmpty());
      return;
    }

    emit(const CartStateLoading());

    final cartDetailResult = await _getCartDetailUseCase.call(event.cart);
    if (cartDetailResult.isSuccess) {
      emit(CartStateShowDetail(cartDetailResult.data!));
    } else {
      debugPrint('ERROR: ${cartDetailResult.exception}');
      emit(const CartStateError());
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}
