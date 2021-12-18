import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/task.dart' as T;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/voucher_vault_app.dart';
import 'package:vouchervault/hooks/hooks.dart';
import 'package:vouchervault/lib/option.dart';
import 'package:vouchervault/models/voucher.dart' as V;
import 'package:vouchervault/models/voucher.dart' show Voucher;
import 'package:vouchervault/voucher_dialog/voucher_dialog.dart';
import 'package:vouchervault/voucher_form_dialog/voucher_form_dialog.dart';
import 'package:vouchervault/vouchers/vouchers_bloc.dart';

part 'voucher_dialog_container.g.dart';

@hcwidget
Widget voucherDialogContainer(
  BuildContext context,
  WidgetRef ref, {
  required Voucher voucher,
}) {
  // Full brightness unless text barcode
  useFullBrightness(
    routeObserver,
    enabled: voucher.codeType != V.VoucherCodeType.TEXT,
  );

  // state
  final bloc = ref.watch(vouchersProvider.bloc);
  final v =
      ref.watch(voucherProvider(voucher.uuid)).p(O.getOrElse(() => voucher));

  final onTapBarcode = useCallback(
    () => v.code.p(O.map((code) {
      Clipboard.setData(ClipboardData(text: code));
      Fluttertoast.showToast(msg: 'Copied to clipboard');
    })),
    [v.code],
  );

  final onSpend = useCallback(
    (() => showDialog<String>(
              context: context,
              builder: (context) => VoucherSpendDialog(),
            ))
        .p(T.map(optionOfString))
        .p(T.map(maybeUpdateVoucherBalance(v)))
        .p(T.map(bloc.add)),
    [bloc, v],
  );

  final onEdit = useCallback(() async {
    final voucher = await Navigator.push<Voucher>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => VoucherFormDialog(initialValue: O.some(v)),
      ),
    );

    O.fromNullable(voucher).p(O.map(updateVoucher)).p(O.map(bloc.add));
  }, [bloc, v]);

  final onRemove = useCallback(
    () => showDialog<bool>(
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
              bloc.add(removeVoucher(v));
              Navigator.pop(context, true);
            },
            child: Text('Remove'),
          ),
        ],
      ),
    ).then((removed) {
      if (removed != true) return;
      Navigator.pop(context);
    }),
    [bloc, v],
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
