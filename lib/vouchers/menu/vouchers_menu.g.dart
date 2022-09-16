// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vouchers_menu.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class VouchersMenu extends StatelessWidget {
  const VouchersMenu({
    Key? key,
    required this.onSelected,
    required this.values,
    required this.disabled,
  }) : super(key: key);

  final void Function(VouchersMenuAction) onSelected;

  final Map<VouchersMenuAction, bool> values;

  final Set<VouchersMenuAction> disabled;

  @override
  Widget build(BuildContext _context) => vouchersMenu(
        onSelected: onSelected,
        values: values,
        disabled: disabled,
      );
}
