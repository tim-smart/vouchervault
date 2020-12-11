import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_stream/flutter_bloc_stream.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/app_scaffold/app_scaffold.dart';
import 'package:vouchervault/models/models.dart';
import 'package:vouchervault/voucher_dialog/voucher_dialog_container.dart';
import 'package:vouchervault/voucher_form_dialog/voucher_form_dialog.dart';
import 'package:vouchervault/vouchers/vouchers.dart';
import 'package:vouchervault/vouchers/vouchers_menu/vouchers_menu_container.dart';

part 'vouchers_screen.g.dart';

@swidget
Widget vouchersScreen(BuildContext context) => AppScaffold(
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
          sliver: BlocStreamBuilder<VouchersBloc, VouchersState>(
            builder: (context, s) => VoucherList(
              vouchers: s.vouchers,
              onPressed: (v) {
                showDialog(
                  context: context,
                  builder: (context) => Dismissible(
                    key: Key('VoucherDialogDismissable'),
                    direction: DismissDirection.vertical,
                    onDismissed: (d) => Navigator.pop(context),
                    child: Center(
                      child: VoucherDialogContainer(voucher: v),
                    ),
                  ),
                );
              },
            ),
          ),
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
            .map(BlocStreamProvider.of<VouchersBloc>(context).add)),
        child: Icon(Icons.add),
      )),
    );
