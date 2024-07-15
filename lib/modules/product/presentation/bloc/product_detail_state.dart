part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailState {
  final int quantity;
  final Decimal total;

  const ProductDetailState(
    this.quantity,
    this.total,
  );
}

final class ProductDetailInitial extends ProductDetailState {
  ProductDetailInitial() : super(0, Decimal.zero);
}

final class ProductDetailUpdatedQuantity extends ProductDetailState {
  const ProductDetailUpdatedQuantity(super.quantity, super.total);
}

final class ProductDetailStateItemCartAdded extends ProductDetailState {
  ProductDetailStateItemCartAdded() : super(0, Decimal.zero);
}

final class ProductDetailStateItemCartError extends ProductDetailState {
  const ProductDetailStateItemCartError(super.quantity, super.total);
}
