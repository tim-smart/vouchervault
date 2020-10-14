import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/hooks/hooks.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/models/models.dart';

export 'voucher_dialog_container.dart';
export 'voucher_spend_dialog.dart';

part 'voucher_dialog.g.dart';

@hwidget
Widget voucherDialog(
  BuildContext context, {
  @required Voucher voucher,
  @required void Function(Voucher) onEdit,
  @required VoidCallback onClose,
  @required void Function(Voucher) onRemove,
  @required void Function(Voucher) onSpend,
}) {
  // Full brightness while we show the barcode
  useFullBrightness();

  // colors
  final color = voucherColor(voucher.color);
  final textColor =
      color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  var theme = Theme.of(context);
  theme = theme.copyWith(
    textTheme: theme.textTheme.apply(
      bodyColor: textColor,
      displayColor: textColor,
    ),
  );

  return _DialogWrap(
    voucherColor(voucher.color),
    Padding(
      padding: EdgeInsets.all(AppTheme.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            voucher.description,
            style: theme.textTheme.headline3,
          ),
          ...voucher.codeOption.fold(
            () => [],
            (data) => [
              SizedBox(height: AppTheme.space3),
              _Barcode(voucherCodeType(voucher.codeType), data),
            ],
          ),
          if (voucher.hasDetails) ...[
            SizedBox(height: AppTheme.space4),
            ...buildVoucherDetails(
              context,
              voucher,
              textColor: textColor,
            ),
          ],
          SizedBox(height: AppTheme.space4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (voucher.balanceOption.isSome())
                IconButton(
                  color: textColor,
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () => onSpend(voucher),
                ),
              IconButton(
                color: textColor,
                icon: Icon(Icons.delete),
                onPressed: () => onRemove(voucher),
              ),
              SizedBox(width: AppTheme.space3),
              RaisedButton(
                color: theme.accentColor,
                onPressed: () => onEdit(voucher),
                child: Text('Edit'),
              ),
              SizedBox(width: AppTheme.space3),
              RaisedButton(
                color: Colors.white,
                onPressed: onClose,
                child: Text('Close'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

@swidget
Widget _dialogWrap(BuildContext context, Color color, Widget child) {
  // colors
  final textColor =
      color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  var theme = Theme.of(context);
  theme = theme.copyWith(
    textTheme: theme.textTheme.apply(
      bodyColor: textColor,
      displayColor: textColor,
    ),
  );

  return Theme(
    data: theme,
    child: Padding(
      padding: EdgeInsets.all(AppTheme.space4),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.rem(1)),
          ),
          color: color,
          child: child,
        ),
      ),
    ),
  );
}

@swidget
Widget _barcode(BuildContext context, Barcode barcode, String data) {
  final theme = Theme.of(context);
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        AppTheme.rem(0.5),
      ),
      color: Colors.white,
    ),
    height: AppTheme.rem(10),
    child: Padding(
      padding: EdgeInsets.all(AppTheme.space4),
      child: BarcodeWidget(
        data: data,
        style: theme.textTheme.bodyText2.copyWith(
          color: Colors.black,
        ),
        barcode: barcode,
      ),
    ),
  );
}
