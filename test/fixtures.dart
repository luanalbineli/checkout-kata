import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:decimal/decimal.dart';

class Fixtures {
  Fixtures._();
  
  static final productA = Product(
    sku: 'A',
    price: Decimal.fromJson('2.40'),
    name: 'Product A',
    imageUrl: null,
  );

  static final productB = Product(
    sku: 'B',
    price: Decimal.fromJson('1.9'),
    name: 'Product B',
    imageUrl: null,
  );

  static final productC = Product(
    sku: 'C',
    price: Decimal.fromJson('1.40'),
    name: 'Product C',
    imageUrl: null,
  );
}
