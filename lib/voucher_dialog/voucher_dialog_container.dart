import 'package:flutter/material.dart';
import 'package:flutter_bloc_stream/flutter_bloc_stream.dart';
import 'package:vouchervault/app/vouchers_bloc.dart';
import 'package:vouchervault/models/models.dart';
import 'package:vouchervault/voucher_dialog/voucher_dialog.dart';

class VoucherDialogContainer extends StatelessWidget {
  final Voucher voucher;
  final void Function(Voucher) onEdit;
  final VoidCallback onClose;
  final void Function(Voucher) onRemove;

  const VoucherDialogContainer({
    Key key,
    @required this.voucher,
    @required this.onEdit,
    @required this.onClose,
    @required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocStreamBuilder<VouchersBloc, VouchersState>(
        builder: (context, s) => VoucherDialog(
          voucher:
              s.data.vouchers.find((v) => v.uuid == voucher.uuid) | Voucher(),
          onEdit: onEdit,
          onClose: onClose,
          onRemove: onRemove,
        ),
      );
}
