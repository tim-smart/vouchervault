import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/vouchers/vouchers_bloc.dart';
import 'package:vouchervault/vouchers/vouchers_menu/vouchers_menu.dart';

part 'vouchers_menu_container.g.dart';

@hwidget
Widget vouchersMenuContainer() {
  final bloc = useProvider(vouchersProvider);

  return VouchersMenu(onSelected: (action) {
    switch (action) {
      case VouchersMenuAction.EXPORT:
        bloc.add(VoucherActions.export());
        break;
      case VouchersMenuAction.IMPORT:
        bloc.add(VoucherActions.import());
        break;
    }
  });
}
