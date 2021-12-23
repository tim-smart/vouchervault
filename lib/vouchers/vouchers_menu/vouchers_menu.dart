import 'package:enum_utils/enum_utils.dart' as enums;
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'vouchers_menu.g.dart';

enum VouchersMenuAction {
  import,
  export,
  authentication,
}

final _actionLabel = enums.valueMap({
  VouchersMenuAction.import: 'Import',
  VouchersMenuAction.export: 'Export',
  VouchersMenuAction.authentication: 'App lock',
}, () => 'N/A');

final _actionHasCheckbox = enums.valueMap({
  VouchersMenuAction.authentication: true,
}, () => false);

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
                    Text(_actionLabel(a)),
                    if (_actionHasCheckbox(a)) ...[
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
