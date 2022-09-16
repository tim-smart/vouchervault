import 'package:enum_utils/enum_utils.dart' as enums;
import 'package:flutter/material.dart';
import 'package:flutter_nucleus/flutter_nucleus.dart';
import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/auth/auth.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

part 'vouchers_menu_container.g.dart';

final _actionMap = enums.optionValueMap({
  VouchersMenuAction.import: import,
  VouchersMenuAction.export: export,
});

final _authActionMap = enums.optionValueMap({
  VouchersMenuAction.authentication: toggle,
});

final _contextActionMap = enums.optionValueMap({
  VouchersMenuAction.smartScan: (BuildContext x) =>
      x.updateAtom(appSettings)((s) => s.copyWith(smartScan: !s.smartScan)),
});

@swidget
Widget vouchersMenuContainer() => AtomBuilder((context, watch, child) {
      final bloc = watch(vouchersState.parent);

      final authSM = watch(authState.parent);
      final authEnabled = watch(authEnabledAtom);
      final authAvailable = watch(authAvailableAtom);

      final settings = watch(appSettings);

      return VouchersMenu(
        onSelected: (action) {
          _actionMap(action).p(tap(bloc.evaluate));
          _authActionMap(action).p(tap(authSM.run));
          _contextActionMap(action).p(tap((f) => f(context)));
        },
        values: {
          VouchersMenuAction.authentication: authEnabled,
          VouchersMenuAction.smartScan: settings.smartScan,
        },
        disabled: {
          if (!authAvailable) VouchersMenuAction.authentication,
        },
      );
    });
