import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_stream/flutter_bloc_stream.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/app_scaffold/app_scaffold.dart';
import 'package:vouchervault/models/models.dart';
import 'package:vouchervault/voucher_form_dialog/voucher_form_dialog.dart';
import 'package:vouchervault/voucher_list/voucher_list.dart';

class VouchersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Vouchers',
      slivers: [
        SliverPadding(padding: EdgeInsets.only(top: AppTheme.space3)),
        BlocStreamBuilder<VouchersBloc, VouchersState>(
            builder: (context, s) => VoucherList(vouchers: s.data.sorted)),
      ],
      floatingActionButton: some(FloatingActionButton(
        onPressed: () async {
          final voucher = await Navigator.push<Voucher>(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => VoucherFormDialog(),
            ),
          );

          optionOf(voucher)
              .map(VoucherActions.add)
              .map(BlocStreamProvider.of<VouchersBloc>(context).add);
        },
        child: Icon(Icons.add),
      )),
    );
  }
}
