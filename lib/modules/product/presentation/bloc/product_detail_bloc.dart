import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkout/modules/cart/domain/use_case/add_product_cart_use_case.dart';
import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

@injectable
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final AddProductCartUseCase _addProductCartUseCase;

  ProductDetailBloc(this._addProductCartUseCase)
      : super(const ProductDetailInitial()) {
    on<ProductDetailEventUpdateQuantity>(_updateQuantity);
    on<ProductDetailEventAddCart>(_addProductCard);
  }

  FutureOr<void> _updateQuantity(
    ProductDetailEventUpdateQuantity event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(
      ProductDetailUpdatedQuantity(
        event.quantity,
        event.quantity * event.product.price,
      ),
    );
  }

  FutureOr<void> _addProductCard(
    ProductDetailEventAddCart event,
    Emitter<ProductDetailState> emit,
  ) {
    final params = AddProductCartParams(event.product, state.quantity);

    final result = _addProductCartUseCase.call(params);
    if (result.isSuccess) {
      emit(const ProductDetailStateItemCartAdded());
    } else {
      emit(ProductDetailStateItemCartError(state.quantity, state.total));
    }
  }
}
