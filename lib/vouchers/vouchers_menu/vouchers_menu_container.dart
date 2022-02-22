import 'package:enum_utils/enum_utils.dart' as enums;
import 'package:flutter/material.dart';
import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/auth/ops.dart';
import 'package:vouchervault/auth/providers.dart';
import 'package:vouchervault/vouchers/vouchers_bloc.dart';
import 'package:vouchervault/vouchers/vouchers_menu/vouchers_menu.dart';

part 'vouchers_menu_container.g.dart';

final _actionMap = enums.optionValueMap({
  VouchersMenuAction.import: importVouchers,
  VouchersMenuAction.export: exportVouchers,
});

final _authActionMap = enums.optionValueMap({
  VouchersMenuAction.authentication: toggle,
});

@cwidget
Widget vouchersMenuContainer(WidgetRef ref) {
  final bloc = ref.watch(vouchersProvider.bloc);

  final authSM = ref.watch(authSMProvider);
  final authEnabled = ref.watch(authEnabledProvider);
  final authAvailable = ref.watch(authAvailableProvider);

  return VouchersMenu(
    onSelected: (action) {
      _actionMap(action).p(tap((a) => bloc.add(a())));
      _authActionMap(action).p(tap(authSM.run));
    },
    values: {
      VouchersMenuAction.authentication: authEnabled,
    },
    disabled: {
      if (!authAvailable) VouchersMenuAction.authentication,
    },
  );
}
