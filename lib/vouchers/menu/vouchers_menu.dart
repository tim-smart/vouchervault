import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'vouchers_menu.g.dart';

enum VouchersMenuAction {
  import,
  export,
  authentication(hasCheckbox: true),
  smartScan(hasCheckbox: true);

  const VouchersMenuAction({
    this.hasCheckbox = false,
  });

  String label(AppLocalizations locales) {
    switch (this) {
      case VouchersMenuAction.import:
        return locales.import;
      case VouchersMenuAction.export:
        return locales.export;
      case VouchersMenuAction.authentication:
        return locales.appLock;
      case VouchersMenuAction.smartScan:
        return locales.smartScan;
    }
  }

  final bool hasCheckbox;
}

@swidget
Widget vouchersMenu({
  required void Function(VouchersMenuAction) onSelected,
  required Map<VouchersMenuAction, bool> values,
  required Set<VouchersMenuAction> disabled,
}) =>
    PopupMenuButton<VouchersMenuAction>(
      onSelected: onSelected,
      itemBuilder: (context) => VouchersMenuAction.values
          .map<PopupMenuEntry<VouchersMenuAction>>((a) => PopupMenuItem(
                value: a,
                enabled: !disabled.contains(a),
                child: Row(
                  children: [
                    Text(a.label(AppLocalizations.of(context)!)),
                    if (a.hasCheckbox) ...[
                      const Spacer(),
                      Checkbox(
                        value: values[a] ?? false,
                        onChanged: disabled.contains(a)
                            ? null
                            : (_) {
                                onSelected(a);
                                Navigator.of(context).pop();
                              },
                      ),
                    ]
                  ],
                ),
              ))
          .toList(),
    );
