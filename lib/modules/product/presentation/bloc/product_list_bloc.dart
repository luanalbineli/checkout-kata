import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkout/modules/core/domain/use_case/no_params.dart';
import 'package:checkout/modules/product/domain/entity/product_display.dart';
import 'package:checkout/modules/product/domain/use_case/get_product_list_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

@injectable
class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductListUseCase _getProductListUseCase;

  ProductListBloc(this._getProductListUseCase)
      : super(ProductListStateLoading()) {
    on<ProductListEventInit>(_init);

    add(const ProductListEventInit());
  }

  FutureOr<void> _init(
    ProductListEventInit event,
    Emitter<ProductListState> emit,
  ) async {
    final result = await _getProductListUseCase.call(NoParams.instance);
    if (result.data != null) {
      emit(ProductListStateSuccess(result.data!));
    } else {
      emit(ProductListStateError());
    }
  }
}
