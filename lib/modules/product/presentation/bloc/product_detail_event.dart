part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailEvent {
  const ProductDetailEvent();
}

class ProductDetailEventUpdateQuantity extends ProductDetailEvent {
  final Product product;
  final int quantity;

  const ProductDetailEventUpdateQuantity(this.product, this.quantity);
}

class ProductDetailEventAddCart extends ProductDetailEvent {
  final Product product;

  const ProductDetailEventAddCart(this.product);
}
