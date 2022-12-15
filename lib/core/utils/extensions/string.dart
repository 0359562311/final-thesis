import 'package:intl/intl.dart';

DateFormat df = DateFormat("HH:mm dd/MM/yyyy");

extension StringExtension on String? {
  String get date => df.format(DateTime.parse(this ?? "").toLocal());
}
