import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart' as O;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/barcode.dart' as B;
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/models/voucher.dart' as V;
import 'package:vouchervault/models/voucher.dart' show Voucher, VoucherCodeType;

export 'voucher_dialog_container.dart';
export 'voucher_spend_dialog.dart';

part 'voucher_dialog.g.dart';

@swidget
Widget voucherDialog(
  BuildContext context, {
  required Voucher voucher,
  required VoidCallback onTapBarcode,
  required void Function() onEdit,
  required VoidCallback onClose,
  required void Function() onRemove,
  required void Function() onSpend,
}) {
  // colors
  final color = V.color(voucher.color);
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
          ...voucher.codeOption.chain(O.fold(
            () => [],
            (data) => [
              SizedBox(height: AppTheme.space3),
              _Barcode(
                type: voucher.codeType,
                data: data,
                onTap: onTapBarcode,
              ),
            ],
          )),
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
              if (O.isSome(voucher.balanceOption))
                IconButton(
                  color: textColor,
                  icon: Icon(Icons.shopping_cart),
                  onPressed: onSpend,
                ),
              IconButton(
                color: textColor,
                icon: Icon(Icons.delete),
                onPressed: onRemove,
              ),
              SizedBox(width: AppTheme.space3),
              ElevatedButton(
                onPressed: onEdit,
                child: Text('Edit'),
              ),
              SizedBox(width: AppTheme.space3),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
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
  required ThemeData theme,
  required Widget child,
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
  required V.VoucherCodeType type,
  required String data,
  required VoidCallback onTap,
}) {
  final theme = Theme.of(context);
  final barcode = B.fromCodeType(type);
  return SizedBox(
    height: AppTheme.rem(barcode.chain(O.fold(
      () => 6,
      (_) => 10,
    ))),
    child: Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(AppTheme.rem(0.5)),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.rem(0.5)),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppTheme.space4),
          child: barcode.chain(O.fold(
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
              style: theme.textTheme.bodyText2!.copyWith(
                color: Colors.black,
              ),
              barcode: type,
            ),
          )),
        ),
      ),
    ),
  );
}
