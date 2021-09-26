import 'package:fpdart/fpdart.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/app_scaffold/app_scaffold.dart';
import 'package:vouchervault/models/voucher.dart';
import 'package:vouchervault/voucher_form_dialog/voucher_form_dialog.dart';
import 'package:vouchervault/vouchers/voucher_list/vouchers_list_container.dart';
import 'package:vouchervault/vouchers/vouchers_bloc.dart';
import 'package:vouchervault/vouchers/vouchers_menu/vouchers_menu_container.dart';

part 'vouchers_screen.g.dart';

@cwidget
Widget vouchersScreen(BuildContext context, WidgetRef ref) {
  return AppScaffold(
    title: 'Vouchers',
    actions: [
      VouchersMenuContainer(),
    ],
    slivers: [
      SliverPadding(
        padding: EdgeInsets.only(
          top: AppTheme.space3,
          bottom: AppTheme.space6,
        ),
        sliver: VouchersListContainer(),
      ),
    ],
    floatingActionButton: some(FloatingActionButton(
      onPressed: () => Navigator.push<Voucher>(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => VoucherFormDialog(),
        ),
      ).then((v) => optionOf(v)
          .map(VoucherActions.add)
          .map(ref.read(vouchersProvider.bloc).add)),
      child: Icon(Icons.add),
    )),
  );
}
