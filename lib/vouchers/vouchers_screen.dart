import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_stream/flutter_bloc_stream.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/app_scaffold/app_scaffold.dart';
import 'package:vouchervault/models/models.dart';
import 'package:vouchervault/voucher_dialog/voucher_dialog_container.dart';
import 'package:vouchervault/voucher_form_dialog/voucher_form_dialog.dart';
import 'package:vouchervault/voucher_list/voucher_list.dart';

class VouchersScreen extends StatelessWidget {
  void Function(Voucher) _onRemove(BuildContext context) =>
      (v) => showDialog<bool>(
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
                    BlocStreamProvider.of<VouchersBloc>(context)
                        .add(VoucherActions.remove(v));
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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Vouchers',
      slivers: [
        SliverPadding(padding: EdgeInsets.only(top: AppTheme.space3)),
        BlocStreamBuilder<VouchersBloc, VouchersState>(
          builder: (context, s) => VoucherList(
            vouchers: s.data.sorted,
            onPressed: (v) {
              showDialog(
                context: context,
                builder: (context) => Center(
                  child: VoucherDialogContainer(
                    voucher: v,
                    onClose: () => Navigator.pop(context),
                    onRemove: _onRemove(context),
                    onEdit: (v) async {
                      final voucher = await Navigator.push<Voucher>(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => VoucherFormDialog(
                            initialValue: some(v),
                          ),
                        ),
                      );

                      optionOf(voucher).map(VoucherActions.add).map(
                          BlocStreamProvider.of<VouchersBloc>(context).add);
                    },
                  ),
                ),
              );
            },
          ),
        ),
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
