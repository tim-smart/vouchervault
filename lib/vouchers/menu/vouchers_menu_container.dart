import 'package:flutter/material.dart';
import 'package:flutter_nucleus/flutter_nucleus.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/auth/auth.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

part 'vouchers_menu_container.g.dart';

extension _VoucherMenuActions on VouchersMenuAction {
  void execute(BuildContext x) {
    switch (this) {
      case VouchersMenuAction.import:
        x.getAtom(vouchersState.parent).run(import);
        return;
      case VouchersMenuAction.export:
        x.getAtom(vouchersState.parent).run(export);
        return;
      case VouchersMenuAction.authentication:
        x.getAtom(authState.parent).run(toggle);
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
