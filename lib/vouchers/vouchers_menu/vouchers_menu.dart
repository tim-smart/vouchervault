import 'package:fpdart/fpdart.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'vouchers_menu.g.dart';

enum VouchersMenuAction { IMPORT, EXPORT }

final _actionLabels = {
  VouchersMenuAction.IMPORT: "Import",
  VouchersMenuAction.EXPORT: "Export",
};
String _actionLabel(VouchersMenuAction a) =>
    optionOf(_actionLabels[a]).getOrElse(() => "N/A");

@swidget
Widget vouchersMenu({
  required void Function(VouchersMenuAction) onSelected,
}) =>
    PopupMenuButton<VouchersMenuAction>(
      onSelected: onSelected,
      itemBuilder: (context) => VouchersMenuAction.values
          .map((a) => PopupMenuItem(
                value: a,
                child: Text(_actionLabel(a)),
              ))
          .toList(),
    );
