import 'package:intl/intl.dart';

String formatNumber(num number) {
  final formatter = NumberFormat('#,###', 'en_US');
  return formatter.format(number);
}
