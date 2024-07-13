import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:checkout/modules/cart/domain/repository/cart_repository.dart';
import 'package:checkout/modules/core/domain/use_case/no_params.dart';
import 'package:checkout/modules/core/domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartStreamUseCase extends UseCase<NoParams, Stream<Cart>> {
  final CartRepository _cartRepository;

  const GetCartStreamUseCase(this._cartRepository);

  @override
  Stream<Cart> execute(NoParams params) => _cartRepository.getStream();
}
