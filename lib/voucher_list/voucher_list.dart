import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:vouchervault/models/voucher.dart';
import 'package:vouchervault/voucher_list/voucher_item.dart';

class VoucherList extends StatelessWidget {
  const VoucherList({
    Key key,
    @required this.vouchers,
  }) : super(key: key);

  final IList<Voucher> vouchers;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        vouchers
            .map((v) => VoucherItem(
                  voucher: v,
                  onPressed: () {},
                ))
            .toList(),
      ),
    );
  }
}
