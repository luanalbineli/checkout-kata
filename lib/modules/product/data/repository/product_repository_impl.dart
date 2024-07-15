import 'package:checkout/modules/product/data/data_source/product_remote_data_source.dart';
import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:checkout/modules/product/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;

  const ProductRepositoryImpl(this._productRemoteDataSource);

  @override
  Future<List<Product>> getList() async {
    final productList = await _productRemoteDataSource.getList();
    return productList.map((product) => product.toEntity()).toList();
  }
}
