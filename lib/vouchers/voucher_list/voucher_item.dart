import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/models/voucher.dart';

part 'voucher_item.g.dart';

@swidget
Widget voucherItem(
  BuildContext context, {
  @required Voucher voucher,
  @required VoidCallback onPressed,
}) {
  final color = voucherColor(voucher.color);
  final textColor =
      color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  final theme = Theme.of(context);

  return RaisedButton(
    padding: EdgeInsets.zero,
    elevation: 10,
    focusElevation: 12,
    highlightElevation: 12,
    shape: RoundedRectangleBorder(),
    color: color,
    textColor: textColor,
    onPressed: onPressed,
    child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.space4,
          vertical: AppTheme.space4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(voucher.description,
                style: theme.textTheme.headline3.copyWith(
                  color: textColor,
                )),
            if (voucher.hasDetails) ...[
              SizedBox(height: AppTheme.space2),
              ...buildVoucherDetails(
                context,
                voucher,
                textColor: textColor,
              ),
            ]
          ],
        ),
      ),
    ),
  );
}
