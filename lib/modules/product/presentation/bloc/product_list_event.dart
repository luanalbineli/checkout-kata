part of 'product_list_bloc.dart';

@immutable
sealed class ProductListEvent {
  const ProductListEvent();
}

class ProductListEventInit extends ProductListEvent {
  const ProductListEventInit();
}
