import 'package:checkout/modules/core/domain/use_case/no_params.dart';
import 'package:checkout/modules/core/domain/use_case/use_case.dart';
import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:checkout/modules/product/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductListUseCase extends AsyncUseCase<NoParams, List<Product>> {
  final ProductRepository _productRepository;

  GetProductListUseCase(this._productRepository);

  @override
  Future<List<Product>> execute(NoParams params) {
    return _productRepository.getList();
  }
}
