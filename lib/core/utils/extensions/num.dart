import 'package:intl/intl.dart';

NumberFormat _format = NumberFormat("###,###");

extension NumExtension on num {
  String get price {
    return _format.format(this);
  }
}
