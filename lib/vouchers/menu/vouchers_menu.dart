import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'vouchers_menu.g.dart';

// TODO: i18n
enum VouchersMenuAction {
  import(label: "Import"),
  export(label: "Export"),
  authentication(
    label: "App lock",
    hasCheckbox: true,
  ),
  smartScan(
    label: "Smart scan",
    hasCheckbox: true,
  );

  const VouchersMenuAction({
    required this.label,
    this.hasCheckbox = false,
  });

  final String label;
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
                    Text(a.label),
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
