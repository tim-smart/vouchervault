import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/voucher_dialog/voucher_dialog.dart';
import 'package:vouchervault/vouchers/vouchers_bloc.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

part 'vouchers_list_container.g.dart';

class _DialogRoute extends PageRoute with MaterialRouteTransitionMixin {
  _DialogRoute(this.builder) : super(fullscreenDialog: true);

  final WidgetBuilder builder;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  bool get opaque => false;

  @override
  bool get maintainState => false;

  @override
  Color get barrierColor => Colors.black54;
}

@cwidget
Widget vouchersListContainer(BuildContext context, WidgetRef ref) {
  final state = ref.watch(vouchersProvider);
  return VoucherList(
    vouchers: state.sortedVouchers,
    onPressed: (v) => Navigator.of(context).push(_DialogRoute(
      (context) => Dismissible(
        key: Key('VoucherDialogDismissable'),
        direction: DismissDirection.vertical,
        onDismissed: (d) => Navigator.pop(context),
        child: Center(child: VoucherDialogContainer(voucher: v)),
      ),
    )),
  );
}
