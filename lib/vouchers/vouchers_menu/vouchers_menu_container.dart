import 'package:enum_utils/enum_utils.dart' as enums;
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/vouchers/vouchers_bloc.dart';
import 'package:vouchervault/vouchers/vouchers_menu/vouchers_menu.dart';

part 'vouchers_menu_container.g.dart';

final _actionMap = enums.optionValueMap({
  VouchersMenuAction.IMPORT: VoucherActions.import(),
  VouchersMenuAction.EXPORT: VoucherActions.export(),
});

@cwidget
Widget vouchersMenuContainer(WidgetRef ref) {
  final bloc = ref.watch(vouchersProvider.bloc);
  return VouchersMenu(
    onSelected: (action) => _actionMap(action).map(bloc.add),
  );
}
