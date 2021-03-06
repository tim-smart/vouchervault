import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/voucher_vault_app.dart';
import 'package:vouchervault/hooks/hooks.dart';
import 'package:vouchervault/lib/option_of_string.dart';
import 'package:vouchervault/models/voucher.dart' as V;
import 'package:vouchervault/models/voucher.dart' show Voucher;
import 'package:vouchervault/voucher_dialog/voucher_dialog.dart';
import 'package:vouchervault/voucher_form_dialog/voucher_form_dialog.dart';
import 'package:vouchervault/vouchers/vouchers_bloc.dart';

part 'voucher_dialog_container.g.dart';

@hwidget
Widget voucherDialogContainer(
  BuildContext context, {
  required Voucher voucher,
}) {
  // Full brightness unless text barcode
  useFullBrightness(
    routeObserver,
    enabled: voucher.codeType != V.VoucherCodeType.TEXT,
  );

  // bloc & state
  final bloc = useProvider(vouchersProvider.bloc);
  final v =
      useProvider(voucherProvider(voucher.uuid ?? '')).getOrElse(() => voucher);

  void onTapBarcode() => v.codeOption.map((code) {
        Clipboard.setData(ClipboardData(text: code));
        Fluttertoast.showToast(msg: 'Copied to clipboard');
      });

  void onSpend(Voucher v) => showDialog<String>(
        context: context,
        builder: (context) => VoucherSpendDialog(),
      )
          .then(optionOfString)
          .then(VoucherActions.maybeUpdateBalance(v))
          .then(bloc.add);

  Future<void> onEdit(Voucher v) async {
    final voucher = await Navigator.push<Voucher>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => VoucherFormDialog(initialValue: some(v)),
      ),
    );

    optionOf(voucher).map(VoucherActions.update).map(bloc.add);
  }

  void onRemove(v) => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text('That you want to remove this voucher?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                bloc.add(VoucherActions.remove(v));
                Navigator.pop(context, true);
              },
              child: Text('Remove'),
            ),
          ],
        ),
      ).then((removed) {
        if (!removed!) return;
        Navigator.pop(context);
      });

  return VoucherDialog(
    voucher: v,
    onTapBarcode: onTapBarcode,
    onEdit: onEdit,
    onClose: () => Navigator.pop(context),
    onRemove: onRemove,
    onSpend: onSpend,
  );
}
