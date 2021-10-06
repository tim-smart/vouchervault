import 'package:enum_utils/enum_utils.dart' as enums;
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/auth/auth_bloc.dart';
import 'package:vouchervault/vouchers/vouchers_bloc.dart';
import 'package:vouchervault/vouchers/vouchers_menu/vouchers_menu.dart';

part 'vouchers_menu_container.g.dart';

final _actionMap = enums.optionValueMap({
  VouchersMenuAction.IMPORT: VoucherActions.import,
  VouchersMenuAction.EXPORT: VoucherActions.export,
});

final _authActionMap = enums.optionValueMap({
  VouchersMenuAction.AUTHENTICATION: AuthActions.toggle,
});

@cwidget
Widget vouchersMenuContainer(WidgetRef ref) {
  final bloc = ref.watch(vouchersProvider.bloc);

  final authBloc = ref.watch(authBlocProvider.bloc);
  final authEnabled = ref.watch(authEnabledProvider);
  final authAvailable = ref.watch(authAvailableProvider);

  return VouchersMenu(
    onSelected: (action) {
      _actionMap(action).map((a) => bloc.add(a()));
      _authActionMap(action).map((a) => authBloc.add(a()));
    },
    values: {
      VouchersMenuAction.AUTHENTICATION: authEnabled,
    },
    disabled: Set.from([
      if (!authAvailable) VouchersMenuAction.AUTHENTICATION,
    ]),
  );
}
