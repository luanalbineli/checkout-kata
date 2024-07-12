import 'package:checkout/modules/product/domain/entity/product.dart';

abstract class ProductRepository {
  const ProductRepository();

  Future<List<Product>> getList();
}
