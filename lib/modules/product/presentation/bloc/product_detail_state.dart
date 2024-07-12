part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailState {
  final int quantity;
  final double total;

  const ProductDetailState(
    this.quantity,
    this.total,
  );
}

final class ProductDetailInitial extends ProductDetailState {
  const ProductDetailInitial() : super(0, 0);
}

final class ProductDetailUpdatedQuantity extends ProductDetailState {
  const ProductDetailUpdatedQuantity(super.quantity, super.total);
}

final class ProductDetailStateItemCartAdded extends ProductDetailState {
  const ProductDetailStateItemCartAdded() : super(0, 0);
}

final class ProductDetailStateItemCartError extends ProductDetailState {
  const ProductDetailStateItemCartError(super.quantity, super.total);
}
