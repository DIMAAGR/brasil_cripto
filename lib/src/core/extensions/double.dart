import 'package:intl/intl.dart';

extension DoubleFormat on double {
  String toBR() {
    final formatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: '',
      decimalDigits: 2,
    );
    return formatter.format(toDouble());
  }
}
