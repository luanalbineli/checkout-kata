import 'package:decimal/decimal.dart';

extension DecimalExtensions on Decimal {
  String get formatWithCurrency => '£${toStringAsFixed(2)}';
}

extension DecimalListExtensions on Iterable<Decimal> {
  Decimal get sum {
    Decimal result = Decimal.zero;
    for (var value in this) {
      result += value;
    }
    return result;
  }
}
