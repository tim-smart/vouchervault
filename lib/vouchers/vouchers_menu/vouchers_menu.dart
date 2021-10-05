import 'package:enum_utils/enum_utils.dart' as enums;
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'vouchers_menu.g.dart';

enum VouchersMenuAction { IMPORT, EXPORT, AUTHENTICATION }

final _actionLabel = enums.valueMap({
  VouchersMenuAction.IMPORT: 'Import',
  VouchersMenuAction.EXPORT: 'Export',
  VouchersMenuAction.AUTHENTICATION: 'App lock',
}, () => 'N/A');

final _actionHasCheckbox = enums.valueMap({
  VouchersMenuAction.AUTHENTICATION: true,
}, () => false);

@swidget
Widget vouchersMenu({
  required void Function(VouchersMenuAction) onSelected,
  required Map<VouchersMenuAction, bool> values,
}) =>
    PopupMenuButton<VouchersMenuAction>(
      onSelected: onSelected,
      itemBuilder: (context) => VouchersMenuAction.values
          .map<PopupMenuEntry<VouchersMenuAction>>((a) => PopupMenuItem(
                value: a,
                child: Row(
                  children: [
                    Text(_actionLabel(a)),
                    if (_actionHasCheckbox(a)) ...[
                      Spacer(),
                      Checkbox(
                        value: values[a] ?? false,
                        onChanged: (_) {
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
