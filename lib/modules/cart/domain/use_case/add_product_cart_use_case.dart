import 'package:checkout/modules/cart/domain/entity/cart_item.dart';
import 'package:checkout/modules/cart/domain/repository/cart_repository.dart';
import 'package:checkout/modules/core/domain/use_case/use_case.dart';
import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductCartUseCase extends UseCase<AddProductCartParams, void> {
  final CartRepository _cartRepository;

  AddProductCartUseCase(this._cartRepository);

  @override
  void execute(AddProductCartParams params) {
    final cart = _cartRepository.get();
    final existingProductIndex = cart.items.indexWhere(
      (cartItem) => cartItem.product == params.product,
    );

    if (existingProductIndex != -1) {
      final existingProduct = cart.items[existingProductIndex];
      cart.items[existingProductIndex] = CartItem(
        params.product,
        params.quantity + existingProduct.quantity,
      );
    } else {
      cart.items.add(CartItem(params.product, params.quantity));
    }

    _cartRepository.update(cart);
  }
}

class AddProductCartParams {
  final Product product;
  final int quantity;

  AddProductCartParams(this.product, this.quantity);
}
