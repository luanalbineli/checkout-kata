import 'package:checkout/modules/cart/data/data_source/cart_local_data_source.dart';
import 'package:checkout/modules/cart/data/model/cart_item_model.dart';
import 'package:checkout/modules/cart/data/model/cart_model.dart';
import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:checkout/modules/cart/domain/repository/cart_repository.dart';
import 'package:checkout/modules/product/data/model/product_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource _cartLocalDataSource;

  CartRepositoryImpl(this._cartLocalDataSource);

  @override
  Cart get() => _cartLocalDataSource.get().toEntity();

  @override
  void update(Cart cart) => _cartLocalDataSource.update(
        _parseCartToModel(cart),
      );

  @override
  Stream<Cart> getStream() => _cartLocalDataSource.getStream().map(
        (cartModel) => cartModel.toEntity(),
      );

  CartModel _parseCartToModel(Cart cart) {
    return CartModel(
      cart.items
          .map(
            (item) => CartItemModel(
              ProductModel(
                sku: item.product.sku,
                name: item.product.name,
                price: item.product.price,
                imageUrl: item.product.imageUrl,
              ),
              item.quantity,
            ),
          )
          .toList(),
    );
  }
}
