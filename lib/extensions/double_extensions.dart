import 'package:decimal/decimal.dart';

extension DoubleExtensions on Decimal {
  String get formatWithCurrency => '£${toStringAsFixed(2)}';
}
