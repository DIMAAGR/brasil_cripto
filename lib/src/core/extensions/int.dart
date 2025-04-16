import 'package:intl/intl.dart';

extension IntToCurrency on int {
  String toBRL({bool withSymbol = true}) {
    final formatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: withSymbol ? 'R\$' : '',
      decimalDigits: 2,
    );
    return formatter.format(toDouble());
  }

  String toUSD({bool withSymbol = true}) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: withSymbol ? '\$ ' : '',
      decimalDigits: 2,
    );
    return formatter.format(toDouble());
  }
}
