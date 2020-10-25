import 'package:dartz/dartz.dart';
import 'package:eyro_toast/eyro_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_stream/flutter_bloc_stream.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/vouchers_bloc.dart';
import 'package:vouchervault/models/models.dart';
import 'package:vouchervault/voucher_dialog/voucher_dialog.dart';
import 'package:vouchervault/voucher_form_dialog/voucher_form_dialog.dart';

part 'voucher_dialog_container.g.dart';

@hwidget
Widget voucherDialogContainer(
  BuildContext context, {
  @required Voucher voucher,
}) {
  final bloc = useBlocStream<VouchersBloc>();
  final vouchersState = useBlocStreamState<VouchersBloc, VouchersState>();
  final v = catching(() =>
          vouchersState.vouchers.firstWhere((v) => v.uuid == voucher.uuid))
      .getOrElse(() => voucher);

  void onTapBarcode() => v.codeOption.map((code) {
        Clipboard.setData(ClipboardData(text: code));
        EyroToast.showToast(text: 'Copied to clipboard');
      });

  void onSpend(Voucher v) => showDialog<String>(
        context: context,
        child: VoucherSpendDialog(),
      )
          .then((s) => optionOf(s)
              .bind((s) => catching(() => double.parse(s)).toOption()))
          .then((a) => Option.map2(
                v.balanceOption,
                a,
                (balance, spend) => v.copyWith(
                  balance: some(balance - spend),
                ),
              ).map(VoucherActions.add).map(bloc.add));

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
            FlatButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel'),
            ),
            FlatButton(
              onPressed: () {
                bloc.add(VoucherActions.remove(v));
                Navigator.pop(context, true);
              },
              child: Text('Remove'),
            ),
          ],
        ),
      ).then((removed) {
        if (!removed) return;
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
