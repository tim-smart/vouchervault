import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/lib/lib.dart' as B;
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/vouchers/index.dart';
import 'package:vouchervault/shared/voucher_details/voucher_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'voucher_dialog_container.dart';
export 'voucher_spend_dialog.dart';

part 'voucher_dialog.g.dart';

@swidget
Widget _voucherDialog(
  BuildContext context, {
  required Voucher voucher,
  required VoidCallback onTapBarcode,
  required void Function() onEdit,
  required VoidCallback onClose,
  required void Function() onRemove,
  required void Function() onSpend,
}) {
  // colors
  final theme = voucher.color.theme(Theme.of(context));

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
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          ...voucher.code.ifSomeList((data) => [
                SizedBox(height: AppTheme.space3),
                _Barcode(
                  type: voucher.codeType,
                  data: data,
                  onTap: onTapBarcode,
                ),
              ]),
          if (voucher.hasDetailsOrNotes) ...[
            SizedBox(height: AppTheme.space4),
            ...buildVoucherDetails(
              context,
              voucher,
              includeNotes: true,
            ),
          ],
          SizedBox(height: AppTheme.space4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (voucher.balanceOption.isSome())
                IconButton(
                  key: const ValueKey('SpendIconButton'),
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: onSpend,
                  color: theme.colorScheme.onPrimary,
                ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onRemove,
                color: theme.colorScheme.onPrimary,
              ),
              SizedBox(width: AppTheme.space3),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: theme.colorScheme.onPrimaryFixed,
                  backgroundColor: theme.colorScheme.primaryFixed,
                ),
                onPressed: onEdit,
                child: Text(AppLocalizations.of(context)!.edit),
              ),
              SizedBox(width: AppTheme.space3),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: theme.colorScheme.onSurface,
                  backgroundColor: theme.colorScheme.surface,
                ),
                onPressed: onClose,
                child: Text(AppLocalizations.of(context)!.close),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

@swidget
Widget __dialogWrap(
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
            color: theme.colorScheme.primary,
            child: child,
          ),
        ),
      ),
    );

@swidget
Widget __barcode(
  BuildContext context, {
  required VoucherCodeType type,
  required String data,
  required VoidCallback onTap,
}) {
  final theme = Theme.of(context);
  final barcode = B.barcodeFromCodeType(type);
  return SizedBox(
    height: AppTheme.rem(barcode.match(
      () => 6,
      (_) => type.square ? 15 : 10,
    )),
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.rem(0.5)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.space4),
        child: barcode.match(
          () => Center(
            child: AutoSizeText(
              data,
              style: const TextStyle(fontSize: 100),
              maxLines: 1,
            ),
          ),
          (type) => BarcodeWidget(
            data: data,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: Colors.black,
            ),
            barcode: type,
          ),
        ),
      ),
    ),
  );
}
