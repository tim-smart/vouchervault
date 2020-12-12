import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc_stream/flutter_bloc_stream.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/vouchers_bloc.dart';
import 'package:vouchervault/vouchers/vouchers_menu/vouchers_menu.dart';

part 'vouchers_menu_container.g.dart';

@hwidget
Widget vouchersMenuContainer() {
  final bloc = useBlocStream<VouchersBloc>();

  return VouchersMenu(onSelected: (action) {
    switch (action) {
      case VouchersMenuAction.EXPORT:
        bloc.add(VoucherActions.export);
        break;
      case VouchersMenuAction.IMPORT:
        bloc.add(VoucherActions.import);
        break;
    }
  });
}
