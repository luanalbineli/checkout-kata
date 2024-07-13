import 'package:checkout/modules/cart/data/data_source/cart_local_data_source.dart';
import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:checkout/modules/cart/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource _cartLocalDataSource;

  CartRepositoryImpl(this._cartLocalDataSource);

  @override
  Cart get() => _cartLocalDataSource.get();

  @override
  void update(Cart cart) => _cartLocalDataSource.update(cart);

  @override
  Stream<Cart> getStream() => _cartLocalDataSource.getStream();
}
