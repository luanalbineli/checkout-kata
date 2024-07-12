import 'dart:async';

import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:injectable/injectable.dart';

abstract class CartLocalDataSource {
  Cart? _last;
  final StreamController<Cart> _cartStreamController =
      StreamController.broadcast();

  Cart get();

  void update(Cart cart);
}

@Injectable(as: CartLocalDataSource)
class CartLocalDataSourceImpl extends CartLocalDataSource {
  CartLocalDataSourceImpl() {
    _cartStreamController.stream.listen((data) {
      _last = data;
    });
  }

  @override
  Cart get() => _last ?? Cart.empty();

  @override
  void update(Cart cart) {
    // TODO: implement update
  }
}
