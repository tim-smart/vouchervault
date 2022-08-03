import 'package:enum_utils/enum_utils.dart' as enums;
import 'package:flutter/material.dart';
import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/providers.dart';
import 'package:vouchervault/auth/ops.dart';
import 'package:vouchervault/auth/providers.dart';
import 'package:vouchervault/vouchers/menu/vouchers_menu.dart';
import 'package:vouchervault/vouchers/ops.dart' as Ops;
import 'package:vouchervault/vouchers/providers.dart';

part 'vouchers_menu_container.g.dart';

final _actionMap = enums.optionValueMap({
  VouchersMenuAction.import: Ops.import,
  VouchersMenuAction.export: Ops.export,
});

final _authActionMap = enums.optionValueMap({
  VouchersMenuAction.authentication: toggle,
});

final _refActionMap = enums.optionValueMap({
  VouchersMenuAction.smartScan: (WidgetRef ref) => ref
      .read(settingsProvider.notifier)
      .update((s) => s.copyWith(smartScan: !s.smartScan)),
});

@cwidget
Widget vouchersMenuContainer(WidgetRef ref) {
  final bloc = ref.watch(vouchersSMProvider);

  final authSM = ref.watch(authSMProvider);
  final authEnabled = ref.watch(authEnabledProvider);
  final authAvailable = ref.watch(authAvailableProvider);
  final smartScanEnabled =
      ref.watch(settingsProvider.select((s) => s.smartScan));

  return VouchersMenu(
    onSelected: (action) {
      _actionMap(action).p(tap(bloc.evaluate));
      _authActionMap(action).p(tap(authSM.run));
      _refActionMap(action).p(tap((f) => f(ref)));
    },
    values: {
      VouchersMenuAction.authentication: authEnabled,
      VouchersMenuAction.smartScan: smartScanEnabled,
    },
    disabled: {
      if (!authAvailable) VouchersMenuAction.authentication,
    },
  );
}
