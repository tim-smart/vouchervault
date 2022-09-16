import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_nucleus/flutter_nucleus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/task_option.dart' as TO;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/hooks/hooks.dart';
import 'package:vouchervault/lib/navigator.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

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
  final sm = useAtom(vouchersState.parent);
  final v = useAtom(voucherAtom(voucher.uuid)).p(O.getOrElse(() => voucher));

  final onTapBarcode = useCallback(
    () => v.code.p(O.map((code) {
      Clipboard.setData(ClipboardData(text: code));
      Fluttertoast.showToast(msg: 'Copied to clipboard');
    })),
    [v.code],
  );

  final onSpend = useCallback(
    _showSpendDialog(context)
        .p(TO.map(maybeUpdateBalance(v)))
        .p(TO.tap(sm.run)),
    [sm, v],
  );

  final onEdit = useCallback(
    navPush(
      context,
      () => MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => VoucherFormDialog(initialValue: O.some(v)),
      ),
    ).p(TO.tap((v) => sm.run(update(v)))),
    [sm, v],
  );

  final onRemove = useCallback(
    _showRemoveDialog(context, onPressed: (context) {
      sm.run(remove(v));
      Navigator.pop(context, true);
    }).p(TO.filter(identity)).p(TO.tap((_) => Navigator.of(context).pop())),
    [sm, v],
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

TaskOption<String> _showSpendDialog(BuildContext context) =>
    showDialogTO<String>(
      context: context,
      builder: (context) => const VoucherSpendDialog(),
    );

TaskOption<bool> _showRemoveDialog(
  BuildContext context, {
  required void Function(BuildContext) onPressed,
}) =>
    showDialogTO<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('That you want to remove this voucher?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => onPressed(context),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
