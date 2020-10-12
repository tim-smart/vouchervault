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

  final List<Voucher> vouchers;
  final void Function(Voucher) onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final v = vouchers[index];
          return VoucherItem(
            voucher: v,
            onPressed: () => onPressed(v),
          );
        },
        childCount: vouchers.length,
      ),
    );
  }
}
