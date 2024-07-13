import 'dart:async';

import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_transform/stream_transform.dart';

abstract class CartLocalDataSource {
  Cart? _last;
  final StreamController<Cart> _cartStreamController =
      StreamController.broadcast();

  Cart get();

  Stream<Cart> getStream();

  void update(Cart cart);
}

@Singleton(as: CartLocalDataSource)
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
    _cartStreamController.add(cart);
  }

  @override
  Stream<Cart> getStream() =>
      Stream.value(get()).followedBy(_cartStreamController.stream);
}
