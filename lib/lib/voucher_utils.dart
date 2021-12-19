import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:timeago/timeago.dart' as timeago;
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/models/voucher.dart';

String formatExpires(DateTime dt) {
  dt = dt.endOfDay;
  return dt.isBefore(DateTime.now())
      ? 'Expired'
      : timeago.format(
          dt,
          allowFromNow: true,
        );
}

List<Widget> buildVoucherDetails(
  BuildContext context,
  Voucher voucher, {
  Color textColor = Colors.white,
  Option<double> space = const None(),
}) =>
    intersperse<Widget>(
        SizedBox(height: space.p(O.getOrElse(() => AppTheme.space1))), [
      ...voucher.normalizedExpires.p(O.fold(
        () => [],
        (dt) => [
          buildVoucherDetailRow(
            context,
            textColor,
            Icons.calendar_today,
            formatExpires(dt),
          )
        ],
      )),
      ...voucher.balanceDoubleOption.p(O.fold(
        () => [],
        (b) => [
          buildVoucherDetailRow(
            context,
            textColor,
            Icons.account_balance,
            '\$$b',
          ),
        ],
      )),
    ]).toList();

Widget buildVoucherDetailRow(
  BuildContext context,
  Color textColor,
  IconData icon,
  String text, {
  Option<double> space = const None(),
}) {
  final theme = Theme.of(context);

  return Row(children: [
    Icon(icon, size: AppTheme.rem(1), color: textColor),
    SizedBox(width: AppTheme.space2),
    Text(
      text,
      style: theme.textTheme.bodyText1!.copyWith(
        color: textColor,
      ),
    ),
  ]);
}
