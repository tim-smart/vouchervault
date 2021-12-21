import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/lib/milliunits.dart' as millis;
import 'package:vouchervault/lib/option.dart';
import 'package:vouchervault/models/voucher.dart';

part 'voucher_utils.g.dart';

String formatExpires(DateTime dt) {
  dt = dt.endOfDay;
  return dt.isPast ? 'Expired' : dt.timeago(allowFromNow: true);
}

List<Widget> buildVoucherDetails(
  BuildContext context,
  Voucher voucher, {
  Color textColor = Colors.white,
  Option<double> space = const None(),
}) =>
    intersperse<Widget>(SizedBox(
      height: space.p(O.getOrElse(() => AppTheme.space1)),
    ))([
      ...voucher.normalizedExpires.p(ifSomeList((dt) => [
            _VoucherDetailRow(
              textColor,
              Icons.calendar_today,
              formatExpires(dt),
            )
          ])),
      ...voucher.balanceOption
          .p(O.flatMap(millis.toString))
          .p(ifSomeList((b) => [
                _VoucherDetailRow(
                  textColor,
                  Icons.account_balance,
                  '\$$b',
                ),
              ])),
    ]).toList();

@swidget
Widget _voucherDetailRow(
  BuildContext context,
  Color textColor,
  IconData icon,
  String text,
) {
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
