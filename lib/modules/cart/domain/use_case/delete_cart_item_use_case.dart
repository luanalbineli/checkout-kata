import 'package:checkout/modules/cart/domain/repository/cart_repository.dart';
import 'package:checkout/modules/core/domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteCartItemUseCase extends UseCase<DeleteCartItemParams, void> {
  final CartRepository _cartRepository;

  DeleteCartItemUseCase(this._cartRepository);

  @override
  void execute(DeleteCartItemParams params) {
    final cart = _cartRepository.get();
    final productIndex =
        cart.items.indexWhere((item) => item.product.sku == params.productSku);
    if (productIndex != -1) {
      cart.items.removeAt(productIndex);
      _cartRepository.update(cart);
    }
  }
}

class DeleteCartItemParams {
  final String productSku;

  DeleteCartItemParams(this.productSku);
}
