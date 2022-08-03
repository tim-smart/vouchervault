import 'package:dart_date/dart_date.dart';

String formatExpires(DateTime dt) {
  dt = dt.endOfDay;
  return dt.isPast ? 'Expired' : dt.timeago(allowFromNow: true);
}
