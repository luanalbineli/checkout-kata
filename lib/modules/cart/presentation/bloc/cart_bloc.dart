import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:checkout/modules/cart/domain/entity/cart_detail.dart';
import 'package:checkout/modules/cart/domain/use_case/delete_cart_item_use_case.dart';
import 'package:checkout/modules/cart/domain/use_case/get_cart_detail_use_case.dart';
import 'package:checkout/modules/cart/domain/use_case/get_cart_stream_use_case.dart';
import 'package:checkout/modules/cart/domain/use_case/update_cart_item_quantity_use_case.dart';
import 'package:checkout/modules/core/domain/use_case/no_params.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartStreamUseCase _getCartStreamUseCase;
  final GetCartDetailUseCase _getCartDetailUseCase;
  final UpdateCartItemQuantityUseCase _updateCartItemQuantityUseCase;
  final DeleteCartItemUseCase _deleteCartItemUseCase;
  StreamSubscription<Cart>? _cartSubscription;

  CartBloc(
    this._getCartStreamUseCase,
    this._getCartDetailUseCase,
    this._updateCartItemQuantityUseCase,
    this._deleteCartItemUseCase,
  ) : super(const CartStateLoading()) {
    on<CartEventUpdate>(_updateCartDetail);
    on<CartEventUpdateItemQuantity>(_updateCartItemQuantity);
    on<CartEventDeleteItem>(_deleteItem);

    _cartSubscription =
        _getCartStreamUseCase.call(NoParams.instance).data?.listen(
      (cart) {
        add(CartEventUpdate(cart));
      },
    );
  }

  Future<void>? _updateCartDetail(
    CartEventUpdate event,
    Emitter<CartState> emit,
  ) async {
    if (event.cart.items.isEmpty) {
      emit(const CartStateEmpty());
      return;
    }

    emit(const CartStateLoading());

    final cartDetailResult = await _getCartDetailUseCase.call(event.cart);
    final CartState nextState;
    if (cartDetailResult.isSuccess) {
      nextState = CartStateShowDetail(cartDetailResult.data!);
    } else {
      nextState = const CartStateError();
    }

    emit(nextState);
  }

  void _updateCartItemQuantity(
    CartEventUpdateItemQuantity event,
    Emitter<CartState> emit,
  ) {
    final params =
        UpdateCartItemQuantityParams(event.productSku, event.quantity);
    _updateCartItemQuantityUseCase.call(params);
  }

  void _deleteItem(
    CartEventDeleteItem event,
    Emitter<CartState> emit,
  ) {
    final params = DeleteCartItemParams(event.productSku);
    _deleteCartItemUseCase.call(params);
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}
