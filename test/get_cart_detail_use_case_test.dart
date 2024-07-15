import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:checkout/modules/cart/domain/entity/cart_item.dart';
import 'package:checkout/modules/cart/domain/use_case/get_cart_detail_use_case.dart';
import 'package:checkout/modules/product/domain/repository/promotion_repository.dart';
import 'package:decimal/decimal.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'fixtures.dart';
import 'get_cart_detail_use_case_test.mocks.dart';

@GenerateMocks([PromotionRepository])
void main() {
  final mockPromotionRepository = MockPromotionRepository();
  final useCase = GetCartDetailUseCase(mockPromotionRepository);

  setUp(resetMockitoState);

  group('Without promotion', () {
    when(mockPromotionRepository.getList()).thenAnswer((_) => Future.value([]));

    test(
      'If the item has no promotion, it should simply process as a regular item',
      () async {
        const productAQuantity = 3;
        final cart = Cart([CartItem(Fixtures.productA, productAQuantity)]);
        final result = await useCase.execute(cart);

        expect(result.items.length, 1, reason: 'Should have one item');

        final expectedGrossAmount =
            Fixtures.productA.price * productAQuantity.toDecimal();
        expect(
          result.grossAmount,
          expectedGrossAmount,
          reason: 'The gross amount should match',
        );

        expect(
          result.netAmount,
          expectedGrossAmount,
          reason: 'The net amount should match the gross amount',
        );

        expect(
          result.discountAmount,
          0,
          reason: 'No discount should be applied',
        );

        expect(
          result.itemCount,
          productAQuantity,
          reason: 'Should match the product quantity',
        );
      },
    );
  });
}
