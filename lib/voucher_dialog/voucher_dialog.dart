import 'package:auto_size_text/auto_size_text.dart';
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
  @required VoidCallback onTapBarcode,
  @required void Function(Voucher) onEdit,
  @required VoidCallback onClose,
  @required void Function(Voucher) onRemove,
  @required void Function(Voucher) onSpend,
}) {
  // Full brightness unless text barcode
  useFullBrightness(enabled: voucher.codeType != VoucherCodeType.TEXT);

  // colors
  final color = voucherColor(voucher.color);
  final textColor =
      color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  var theme = Theme.of(context);
  theme = theme.copyWith(
    backgroundColor: color,
    textTheme: theme.textTheme.apply(
      bodyColor: textColor,
      displayColor: textColor,
    ),
  );

  return _DialogWrap(
    theme: theme,
    child: Padding(
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
              _Barcode(
                type: voucher.codeType,
                data: data,
                onTap: onTapBarcode,
              ),
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
Widget _dialogWrap(
  BuildContext context, {
  @required ThemeData theme,
  @required Widget child,
}) =>
    Theme(
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
            color: theme.backgroundColor,
            child: child,
          ),
        ),
      ),
    );

@swidget
Widget _barcode(
  BuildContext context, {
  @required VoucherCodeType type,
  @required String data,
  @required VoidCallback onTap,
}) {
  final theme = Theme.of(context);
  final barcode = barcodeFromVoucherCodeType(type);
  return SizedBox(
    height: AppTheme.rem(barcode.fold(() => 6, (_) => 10)),
    child: Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(AppTheme.rem(0.5)),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.rem(0.5)),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppTheme.space4),
          child: barcode.fold(
            () => Center(
              child: AutoSizeText(
                data,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 100,
                ),
                maxLines: 1,
              ),
            ),
            (type) => BarcodeWidget(
              backgroundColor: Colors.transparent,
              data: data,
              style: theme.textTheme.bodyText2.copyWith(
                color: Colors.black,
              ),
              barcode: type,
            ),
          ),
        ),
      ),
    ),
  );
}
