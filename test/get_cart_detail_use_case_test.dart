import 'package:checkout/modules/cart/domain/entity/cart.dart';
import 'package:checkout/modules/cart/domain/entity/cart_detail.dart';
import 'package:checkout/modules/cart/domain/entity/cart_detail_item.dart';
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

  void assertCartItem(
    CartDetailItem cartDetailItem, {
    required int quantity,
    required Decimal grossTotal,
    required Decimal netTotal,
  }) {
    expect(cartDetailItem.quantity, quantity,
        reason: 'Match cart item product quantity');

    expect(cartDetailItem.grossTotal, grossTotal,
        reason: 'Match cart item gross total');

    expect(cartDetailItem.netTotal, netTotal,
        reason: 'Match cart item net total');
  }

  group('Without promotion', () {
    test(
      'If the item has no promotion, it should simply process as a regular item',
      () async {
        mockPromotions([]);

        const productAQuantity = 3;
        final cart = Cart([CartItem(Fixtures.productA, productAQuantity)]);
        final result = await useCase.execute(cart);

        expect(result.items.length, 1, reason: 'Match items length');

        expect(
          result.items.first is CartDetailItemRegular,
          true,
          reason: 'Match item type',
        );

        final regularCartItem = result.items.first;

        final expectedGrossTotal =
            Fixtures.productA.price * productAQuantity.toDecimal();

        assertCartItem(
          regularCartItem,
          quantity: productAQuantity,
          grossTotal: expectedGrossTotal,
          netTotal: expectedGrossTotal,
        );

        assertCartTotals(
          result,
          grossTotal: expectedGrossTotal,
          netTotal: expectedGrossTotal,
          discountTotal: Decimal.zero,
          itemCount: productAQuantity,
        );
      },
    );
  });

  group('With promotion', () {
    group('Get one free', () {
      const quantityGetNextFree = 3;
      final getOneFreePromotion = PromotionGetOneFree(
        sku: Fixtures.productA.sku,
        quantity: quantityGetNextFree,
      );

      setUp(() => mockPromotions([getOneFreePromotion]));

      test(
        'it should calculate and discount the number of occurrences of the free item',
        () async {
          const productAQuantity = ((quantityGetNextFree + 1) * 2) + 2;
          final cart = Cart([CartItem(Fixtures.productA, productAQuantity)]);

          final result = await useCase.execute(cart);

          expect(
            result.items.first is CartDetailItemPromotion,
            true,
            reason: 'Match item type',
          );

          final promotionCartItem =
              result.items.first as CartDetailItemPromotion;

          expect(
            promotionCartItem.promotion,
            getOneFreePromotion,
            reason: 'Match promotion',
          );

          final expectedGrossTotal =
              Fixtures.productA.price * productAQuantity.toDecimal();

          final expectedNetTotal =
              Fixtures.productA.price * (productAQuantity - 2).toDecimal();

          assertCartItem(
            promotionCartItem,
            quantity: productAQuantity,
            grossTotal: expectedGrossTotal,
            netTotal: expectedNetTotal,
          );

          // Two free items.
          final expectedDiscountAmount =
              Fixtures.productA.price * 2.toDecimal();

          assertCartTotals(
            result,
            grossTotal: expectedGrossTotal,
            netTotal: expectedNetTotal,
            discountTotal: expectedDiscountAmount,
            itemCount: productAQuantity,
          );
        },
      );

      test(
        'if no occurrences were found, it should be treated as a regular item',
        () async {
          const productAQuantity = 1;
          final cart = Cart([CartItem(Fixtures.productA, productAQuantity)]);

          final result = await useCase.execute(cart);

          expect(
            result.items.first is CartDetailItemRegular,
            true,
            reason: 'Match item type',
          );

          final expectedGrossTotal =
              Fixtures.productA.price * productAQuantity.toDecimal();

          assertCartItem(
            result.items.first,
            quantity: productAQuantity,
            grossTotal: expectedGrossTotal,
            netTotal: expectedGrossTotal,
          );

          assertCartTotals(
            result,
            grossTotal: expectedGrossTotal,
            netTotal: expectedGrossTotal,
            discountTotal: Decimal.zero,
            itemCount: productAQuantity,
          );
        },
      );
    });

    group('Multipriced', () {
      const quantityMultipriced = 2;

      final multipricedPromotion = PromotionMultipriced(
        sku: Fixtures.productC.sku,
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

          expect(
            result.items.first is CartDetailItemPromotion,
            true,
            reason: 'Match item type',
          );

          final promotionCartItem =
              result.items.first as CartDetailItemPromotion;

          expect(
            promotionCartItem.promotion,
            multipricedPromotion,
            reason: 'Match promotion',
          );

          final expectedGrossTotal =
              Fixtures.productC.price * productCQuantity.toDecimal();

          final expectedNetTotal =
              (2.toDecimal() * multipricedPromotion.price) +
                  Fixtures.productC.price;

          assertCartItem(
            result.items.first,
            quantity: productCQuantity,
            grossTotal: expectedGrossTotal,
            netTotal: expectedNetTotal,
          );

          final expectedDiscountAmount = 2.toDecimal() *
              ((Fixtures.productC.price *
                      multipricedPromotion.quantity.toDecimal()) -
                  multipricedPromotion.price);

          assertCartTotals(
            result,
            grossTotal: expectedGrossTotal,
            netTotal: expectedNetTotal,
            discountTotal: expectedDiscountAmount,
            itemCount: productCQuantity,
          );
        },
      );

      test(
        'if no occurrences were found, it should be treated as a regular item',
        () async {
          const productCQuantity = 1;
          final cart = Cart([CartItem(Fixtures.productC, productCQuantity)]);

          final result = await useCase.execute(cart);

          expect(
            result.items.first is CartDetailItemRegular,
            true,
            reason: 'Match item type',
          );

          final expectedGrossTotal =
              Fixtures.productC.price * productCQuantity.toDecimal();

          assertCartItem(
            result.items.first,
            quantity: productCQuantity,
            grossTotal: expectedGrossTotal,
            netTotal: expectedGrossTotal,
          );

          assertCartTotals(
            result,
            grossTotal: expectedGrossTotal,
            netTotal: expectedGrossTotal,
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

          expect(
            result.items.first is CartDetailItemPromotion,
            true,
            reason: 'Match item type',
          );

          final promotionCartItemProductA =
              result.items.first as CartDetailItemPromotion;

          expect(
            promotionCartItemProductA.promotion,
            mealDealPromotion,
            reason: 'Match promotion',
          );

          final halfMealDealPrice =
              (mealDealPromotion.price / 2.toDecimal()).toDecimal();

          assertCartItem(
            promotionCartItemProductA,
            quantity: productAQuantity,
            grossTotal: Fixtures.productA.price * productAQuantity.toDecimal(),
            // It should be a full priced item + half of the meal deal price
            netTotal: Fixtures.productA.price + halfMealDealPrice,
          );

          final promotionCartItemProductB =
              result.items[1] as CartDetailItemPromotion;

          assertCartItem(
            promotionCartItemProductB,
            quantity: productBQuantity,
            grossTotal: Fixtures.productB.price,
            // Only half of the meal deal price
            netTotal: halfMealDealPrice,
          );

          final expectedCartGrossTotal =
              Fixtures.productA.price * productAQuantity.toDecimal() +
                  Fixtures.productB.price * productBQuantity.toDecimal();

          final expectedCartNetTotal =
              mealDealPromotion.price + Fixtures.productA.price;

          final expectedCartDiscountTotal =
              (Fixtures.productA.price + Fixtures.productB.price) -
                  mealDealPromotion.price;

          assertCartTotals(
            result,
            grossTotal: expectedCartGrossTotal,
            netTotal: expectedCartNetTotal,
            discountTotal: expectedCartDiscountTotal,
            itemCount: productAQuantity + productBQuantity,
          );
        },
      );

      test(
        'if no occurrences were found, it should be treated as a regular item',
        () async {
          const productAQuantity = 4;
          final cart = Cart([
            CartItem(Fixtures.productA, productAQuantity),
          ]);

          final result = await useCase.execute(cart);

          expect(
            result.items.first is CartDetailItemRegular,
            true,
            reason: 'Match item type',
          );

          final expectedGrossTotal =
              Fixtures.productA.price * productAQuantity.toDecimal();

          assertCartItem(
            result.items.first,
            quantity: productAQuantity,
            grossTotal: expectedGrossTotal,
            netTotal: expectedGrossTotal,
          );

          assertCartTotals(
            result,
            grossTotal: expectedGrossTotal,
            netTotal: expectedGrossTotal,
            discountTotal: Decimal.zero,
            itemCount: productAQuantity,
          );
        },
      );
    });
  });
}
