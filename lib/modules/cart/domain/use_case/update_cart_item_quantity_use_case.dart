import 'package:checkout/modules/cart/domain/entity/cart_item.dart';
import 'package:checkout/modules/cart/domain/repository/cart_repository.dart';
import 'package:checkout/modules/core/domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCartItemQuantityUseCase
    extends UseCase<UpdateCartItemQuantityParams, void> {
  final CartRepository _cartRepository;

  UpdateCartItemQuantityUseCase(this._cartRepository);

  @override
  void execute(UpdateCartItemQuantityParams params) {
    final cart = _cartRepository.get();
    final productIndex =
        cart.items.indexWhere((item) => item.product.sku == params.productSku);
    if (productIndex != -1) {
      final currentCartItem = cart.items[productIndex];
      cart.items[productIndex] = CartItem(
        currentCartItem.product,
        params.quantity,
      );
      _cartRepository.update(cart);
    }
  }
}

class UpdateCartItemQuantityParams {
  final String productSku;
  final int quantity;

  UpdateCartItemQuantityParams(
    this.productSku,
    this.quantity,
  );
}
