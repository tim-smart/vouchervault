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
    final iterator = vouchers.iterator();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          iterator.moveNext();
          final v = iterator.current;

          return VoucherItem(
            voucher: v,
            onPressed: () => onPressed(v),
          );
        },
        childCount: vouchers.length(),
      ),
    );
  }
}
