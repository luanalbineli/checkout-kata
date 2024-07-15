import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:checkout/modules/cart/domain/entity/cart_detail.dart';
import 'package:checkout/modules/cart/domain/entity/cart_item.dart';
import 'package:checkout/modules/cart/domain/use_case/get_cart_detail_use_case.dart';
import 'package:checkout/modules/product/domain/entity/promotion.dart';
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

  void mockPromotions(List<Promotion> promotions) => when(
        mockPromotionRepository.getList(),
      ).thenAnswer((_) => Future.value(promotions));

  void assertCartTotals(
    CartDetail result, {
    required Decimal grossTotal,
    required Decimal netTotal,
    required Decimal discountTotal,
    required int itemCount,
  }) {
    expect(result.grossTotal, grossTotal, reason: 'Gross total');
    expect(result.netTotal, netTotal, reason: 'Net total');
    expect(result.discountTotal, discountTotal, reason: 'Discount');
    expect(
      result.itemCount,
      itemCount,
      reason: 'Should match the product quantity',
    );
  }

  group('Without promotion', () {
    test(
      'If the item has no promotion, it should simply process as a regular item',
      () async {
        mockPromotions([]);

        const productAQuantity = 3;
        final cart = Cart([CartItem(Fixtures.productA, productAQuantity)]);
        final result = await useCase.execute(cart);

        expect(result.items.length, 1, reason: 'Should have one item');

        final expectedGrossAmount =
            Fixtures.productA.price * productAQuantity.toDecimal();

        assertCartTotals(
          result,
          grossTotal: expectedGrossAmount,
          netTotal: expectedGrossAmount,
          discountTotal: Decimal.zero,
          itemCount: productAQuantity,
        );
      },
    );
  });

  group('With promotion', () {
    group('Get one free', () {
      const quantityGetOneFree = 3;
      final getOneFreePromotion = PromotionGetOneFree(
        skus: [Fixtures.productA.sku],
        quantity: quantityGetOneFree,
      );

      setUp(() => mockPromotions([getOneFreePromotion]));

      test(
        'it should calculate and discount the number of occurrences of the free item',
        () async {
          const productAQuantity = (quantityGetOneFree * 2) + 2;
          final cart = Cart([CartItem(Fixtures.productA, productAQuantity)]);

          final result = await useCase.execute(cart);

          final expectedGrossAmount =
              Fixtures.productA.price * productAQuantity.toDecimal();

          final expectedNetAmount =
              Fixtures.productA.price * (productAQuantity - 2).toDecimal();

          final expectedDiscountAmount =
              Fixtures.productA.price * 2.toDecimal();

          assertCartTotals(
            result,
            grossTotal: expectedGrossAmount,
            netTotal: expectedNetAmount,
            discountTotal: expectedDiscountAmount,
            itemCount: productAQuantity,
          );
        },
      );

      test(
        'if no occurrences were found, it should not apply any discount',
        () async {
          const productAQuantity = 1;
          final cart = Cart([CartItem(Fixtures.productA, productAQuantity)]);

          final result = await useCase.execute(cart);

          final expectedGrossAmount =
              Fixtures.productA.price * productAQuantity.toDecimal();

          assertCartTotals(
            result,
            grossTotal: expectedGrossAmount,
            netTotal: expectedGrossAmount,
            discountTotal: Decimal.zero,
            itemCount: productAQuantity,
          );
        },
      );
    });

    group('Multipriced', () {
      const quantityMultipriced = 2;

      final multipricedPromotion = PromotionMultipriced(
        skus: [Fixtures.productC.sku],
        quantity: quantityMultipriced,
        price: Decimal.fromJson('2.50'),
      );

      setUp(() => mockPromotions([multipricedPromotion]));

      test(
        'it should calculate the number of occurrences and apply the new price for each occurrence',
        () async {
          const productCQuantity = (quantityMultipriced * 2) + 1;
          final cart = Cart([CartItem(Fixtures.productC, productCQuantity)]);

          final result = await useCase.execute(cart);

          final expectedGrossAmount =
              Fixtures.productC.price * productCQuantity.toDecimal();

          final expectedNetAmount =
              (2.toDecimal() * multipricedPromotion.price) +
                  Fixtures.productC.price;

          final expectedDiscountAmount = (2.toDecimal() *
              ((Fixtures.productC.price *
                      multipricedPromotion.quantity.toDecimal()) -
                  multipricedPromotion.price));

          assertCartTotals(
            result,
            grossTotal: expectedGrossAmount,
            netTotal: expectedNetAmount,
            discountTotal: expectedDiscountAmount,
            itemCount: productCQuantity,
          );
        },
      );

      test(
        'if no occurrences were found, it should not apply any discount',
        () async {
          const productCQuantity = 1;
          final cart = Cart([CartItem(Fixtures.productC, productCQuantity)]);

          final result = await useCase.execute(cart);

          final expectedGrossAmount =
              Fixtures.productC.price * productCQuantity.toDecimal();

          assertCartTotals(
            result,
            grossTotal: expectedGrossAmount,
            netTotal: expectedGrossAmount,
            discountTotal: Decimal.zero,
            itemCount: productCQuantity,
          );
        },
      );
    });

    group('Meal Deal', () {
      final mealDealPromotion = PromotionMealDeal(
        skus: [Fixtures.productA.sku, Fixtures.productB.sku],
        price: Decimal.fromJson('4.0'),
      );

      setUp(() => mockPromotions([mealDealPromotion]));

      test(
        'it should calculate the number of occurrences and apply the new price for each occurrence',
        () async {
          const productAQuantity = 2;
          const productBQuantity = 1;
          final cart = Cart(
            [
              CartItem(Fixtures.productA, productAQuantity),
              CartItem(Fixtures.productB, productBQuantity)
            ],
          );

          final result = await useCase.execute(cart);

          final expectedGrossAmount =
              Fixtures.productC.price * productAQuantity.toDecimal() +
                  Fixtures.productB.price * productBQuantity.toDecimal();

          final expectedNetAmount =
              mealDealPromotion.price + Fixtures.productA.price;

          final expectedDiscountAmount =
              (Fixtures.productA.price + Fixtures.productB.price) -
                  mealDealPromotion.price;

          assertCartTotals(
            result,
            grossTotal: expectedGrossAmount,
            netTotal: expectedNetAmount,
            discountTotal: expectedDiscountAmount,
            itemCount: productAQuantity + productBQuantity,
          );
        },
      );

      test(
        'if no occurrences were found, it should not apply any discount',
        () async {
          const productAQuantity = 1;
          const productCQuantity = 3;
          final cart = Cart([
            CartItem(Fixtures.productA, productAQuantity),
            CartItem(Fixtures.productC, productCQuantity),
          ]);

          final result = await useCase.execute(cart);

          final expectedGrossAmount =
              Fixtures.productA.price * productAQuantity.toDecimal() +
                  Fixtures.productC.price * productCQuantity.toDecimal();

          assertCartTotals(
            result,
            grossTotal: expectedGrossAmount,
            netTotal: expectedGrossAmount,
            discountTotal: Decimal.zero,
            itemCount: productAQuantity,
          );
        },
      );
    });
  });
}
