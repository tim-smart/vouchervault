import 'package:flutter/material.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/vouchers/models/voucher.dart';

part 'voucher_details.g.dart';

List<Widget> buildVoucherDetails(
  BuildContext context,
  Voucher voucher, {
  Color textColor = Colors.white,
  Option<double> space = const None(),
  bool includeNotes = false,
}) =>
    intersperse<Widget>(SizedBox(
      height: space.p(O.getOrElse(() => AppTheme.space1)),
    ))([
      ...voucher.normalizedExpires.p(ifSomeList((dt) => [
            _VoucherDetailRow(
              textColor,
              Icons.history,
              formatExpires(dt),
            )
          ])),
      ...voucher.balanceOption.p(O.map(millisToString)).p(ifSomeList((b) => [
            _VoucherDetailRow(
              textColor,
              Icons.account_balance,
              '\$$b',
            ),
          ])),
      ...voucher.notesOption
          .p(O.filter((_) => includeNotes))
          .p(ifSomeList((notes) => [
                _VoucherDetailRow(
                  textColor,
                  Icons.article,
                  notes,
                  alignment: CrossAxisAlignment.start,
                  iconPadding: true,
                  selectable: true,
                ),
              ])),
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
            style: theme.textTheme.bodyLarge!.copyWith(
              color: textColor,
            ),
          )
        : Text(
            text,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: textColor,
            ),
          ),
  ]);
}
