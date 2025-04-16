import 'package:intl/intl.dart';

extension FormatDateTime on DateTime {
  String toFormattedString() {
    return DateFormat('dd/MM/yyyy HH:mm').format(toLocal());
  }
}
