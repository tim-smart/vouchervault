import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/vouchers/models/voucher.dart';
import 'package:intl/intl.dart';

part 'voucher_details.g.dart';

final formatCurrency = NumberFormat.simpleCurrency();

List<Widget> buildVoucherDetails(
  BuildContext context,
  Voucher voucher, {
  Color textColor = Colors.white,
  Option<double> space = const Option.none(),
  bool includeNotes = false,
}) =>
    intersperse<Widget>(SizedBox(
      height: space.getOrElse(() => AppTheme.space1),
    ))([
      ...voucher.normalizedExpires.ifSomeList((dt) => [
            _VoucherDetailRow(
              textColor,
              Icons.history,
              formatExpires(dt),
            )
          ]),
      ...voucher.balanceDoubleOption.ifSomeList((b) => [
            _VoucherDetailRow(
              textColor,
              Icons.account_balance,
              formatCurrency.format(b),
            ),
          ]),
      ...voucher.notesOption.filter((_) => includeNotes).ifSomeList((notes) => [
            _VoucherDetailRow(
              textColor,
              Icons.article,
              notes,
              alignment: CrossAxisAlignment.start,
              iconPadding: true,
              selectable: true,
            ),
          ]),
    ]).toList();

@swidget
Widget __voucherDetailRow(
  BuildContext context,
  Color textColor,
  IconData icon,
  String text, {
  CrossAxisAlignment alignment = CrossAxisAlignment.center,
  bool iconPadding = false,
  bool selectable = false,
}) {
  final theme = Theme.of(context);

  return Row(crossAxisAlignment: alignment, children: [
    Padding(
      padding: iconPadding
          ? EdgeInsets.only(top: AppTheme.rem(0.1))
          : EdgeInsets.zero,
      child: Icon(icon, size: AppTheme.rem(1), color: textColor),
    ),
    SizedBox(width: AppTheme.space2),
    selectable
        ? SelectableText(
            text,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: textColor,
            ),
          )
        : Text(
            text,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: textColor,
            ),
          ),
  ]);
}
