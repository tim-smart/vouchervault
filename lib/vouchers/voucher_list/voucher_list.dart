import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:vouchervault/models/voucher.dart';
import 'voucher_item.dart';

export 'voucher_item.dart';

class VoucherList extends StatelessWidget {
  const VoucherList({
    Key key,
    @required this.vouchers,
    @required this.onPressed,
  }) : super(key: key);

  final ISet<Voucher> vouchers;
  final void Function(Voucher) onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        vouchers.foldLeft(
          [],
          (widgets, v) => [
            ...widgets,
            VoucherItem(
              voucher: v,
              onPressed: () => onPressed(v),
            ),
          ],
        ),
      ),
    );
  }
}
