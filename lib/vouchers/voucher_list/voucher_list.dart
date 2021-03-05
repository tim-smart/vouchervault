import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/models/voucher.dart';
import 'voucher_item.dart';

export 'voucher_item.dart';

part 'voucher_list.g.dart';

@swidget
Widget voucherList({
  required List<Voucher> vouchers,
  required void Function(Voucher) onPressed,
}) =>
    SliverList(
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
