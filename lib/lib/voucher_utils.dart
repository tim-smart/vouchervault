import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:time/time.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/models/models.dart';

DateTime endOfDay(DateTime dt) => dt.copyWith(
      hour: 24,
      minute: 59,
      second: 59,
    );

String formatExpires(DateTime dt) {
  dt = endOfDay(dt);
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
    intersperse<Widget>(SizedBox(height: space | AppTheme.space1), [
      ...voucher.expiresOption.fold(
        () => [],
        (dt) => [
          buildVoucherDetailRow(
            context,
            textColor,
            Icons.calendar_today,
            formatExpires(dt),
          )
        ],
      ),
      ...voucher.balanceOption.fold(
        () => [],
        (b) => [
          buildVoucherDetailRow(
            context,
            textColor,
            Icons.account_balance,
            '\$$b',
          )
        ],
      ),
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
      style: theme.textTheme.bodyText1.copyWith(
        color: textColor,
      ),
    ),
  ]);
}
