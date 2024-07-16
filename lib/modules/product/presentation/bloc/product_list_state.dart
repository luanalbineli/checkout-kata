part of 'product_list_bloc.dart';

@immutable
sealed class ProductListState {}

final class ProductListStateLoading extends ProductListState {}

final class ProductListStateSuccess extends ProductListState {
  final List<ProductDisplay> list;

  ProductListStateSuccess(this.list);
}

final class ProductListStateError extends ProductListState {}
