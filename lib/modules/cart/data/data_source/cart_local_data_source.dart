import 'dart:async';

import 'package:checkout/modules/cart/data/model/cart_model.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_transform/stream_transform.dart';

abstract class CartLocalDataSource {
  CartModel? _last;
  final StreamController<CartModel> _cartStreamController =
      StreamController.broadcast();

  CartModel get();

  Stream<CartModel> getStream();

  void update(CartModel cartModel);
}

@Singleton(as: CartLocalDataSource)
class CartLocalDataSourceImpl extends CartLocalDataSource {
  CartLocalDataSourceImpl() {
    _cartStreamController.stream.listen((data) {
      _last = data;
    });
  }

  @override
  CartModel get() => _last ?? CartModel.empty();

  @override
  void update(CartModel cartModel) {
    _cartStreamController.add(cartModel);
  }

  @override
  Stream<CartModel> getStream() =>
      Stream.value(get()).followedBy(_cartStreamController.stream);
}
