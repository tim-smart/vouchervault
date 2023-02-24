import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/hooks/index.dart';
import 'package:vouchervault/lib/navigator.dart';
import 'package:vouchervault/voucher_form/index.dart';
import 'package:vouchervault/vouchers/index.dart';

part 'voucher_dialog_container.g.dart';

@hwidget
Widget _voucherDialogContainer(
  BuildContext context, {
  required Voucher voucher,
}) {
  // Full brightness unless text barcode
  useFullBrightness(
    routeObserver,
    enabled: voucher.codeType != VoucherCodeType.TEXT,
  );

  // state
  final v = useAtom(voucherAtom(voucher.uuid)).getOrElse(() => voucher);

  final onTapBarcode = useCallback(
    () => v.code.map((code) {
      Clipboard.setData(ClipboardData(text: code));
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.copiedToClipboard);
    }),
    [v.code],
  );

  final onSpend = useZIO(
    _showSpendDialog(context).flatMap(
      (amountInput) => vouchersLayer
          .accessWithZIO((_) => _.maybeUpdateBalance(v, amountInput)),
    ),
    [v],
  );

  final onEdit = useZIO(
    navPush(
      context,
      () => MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => VoucherFormDialog(initialValue: Option.of(v)),
      ),
    ).flatMap((v) => vouchersLayer.accessWithZIO((_) => _.update(v))),
    [v],
  );

  final onRemove = useZIO(
    _showRemoveDialog(context, onPressed: (context) {
      context.runZIO(vouchersLayer.accessWithZIO((_) => _.remove(v)));
      Navigator.pop(context, true);
    }).filter(identity).tap((_) => ZIO(() => Navigator.of(context).pop())),
    [v],
  );

  return VoucherDialog(
    voucher: v,
    onTapBarcode: onTapBarcode,
    onEdit: onEdit,
    onClose: () => Navigator.pop(context),
    onRemove: onRemove,
    onSpend: onSpend,
  );
}

IOOption<String> _showSpendDialog(BuildContext context) => showDialogTO<String>(
      context: context,
      builder: (context) => const VoucherSpendDialog(),
    );

IOOption<bool> _showRemoveDialog(
  BuildContext context, {
  required void Function(BuildContext) onPressed,
}) =>
    showDialogTO<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.areYouSure),
        content: Text(AppLocalizations.of(context)!.confirmRemoveVoucher),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => onPressed(context),
            child: Text(AppLocalizations.of(context)!.remove),
          ),
        ],
      ),
    );
