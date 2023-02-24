import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/auth/index.dart';
import 'package:vouchervault/vouchers/index.dart';

part 'vouchers_menu_container.g.dart';

extension _VoucherMenuActions on VouchersMenuAction {
  void execute(BuildContext x) {
    switch (this) {
      case VouchersMenuAction.import:
        x.runZIO(vouchersLayer.accessWithZIO((_) => _.import));
        return;
      case VouchersMenuAction.export:
        x.runZIO(vouchersLayer.accessWithZIO((_) => _.export));
        return;
      case VouchersMenuAction.authentication:
        x.runZIO(authLayer.accessWithZIO((_) => _.toggle));
        return;
      case VouchersMenuAction.smartScan:
        x.updateAtom(appSettings)((s) => s.copyWith(smartScan: !s.smartScan));
        return;
    }
  }
}

@swidget
Widget vouchersMenuContainer() {
  return AtomBuilder((context, watch, child) {
    final authAvailable = watch(authAvailableAtom);

    return VouchersMenu(
      onSelected: (action) => action.execute(context),
      values: {
        VouchersMenuAction.authentication: watch(authEnabledAtom),
        VouchersMenuAction.smartScan: watch(appSettings).smartScan,
      },
      disabled: {
        if (!authAvailable) VouchersMenuAction.authentication,
      },
    );
  });
}
