import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/voucher_dialog/voucher_dialog.dart';
import 'package:vouchervault/vouchers/vouchers_bloc.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

part 'vouchers_list_container.g.dart';

@cwidget
Widget vouchersListContainer(BuildContext context, WidgetRef ref) {
  final state = ref.watch(vouchersProvider);

  return VoucherList(
    vouchers: state.sortedVouchers,
    onPressed: (v) => showDialog(
      context: context,
      builder: (context) => Dismissible(
        key: Key('VoucherDialogDismissable'),
        direction: DismissDirection.vertical,
        onDismissed: (d) => Navigator.pop(context),
        child: Center(child: VoucherDialogContainer(voucher: v)),
      ),
    ),
  );
}
