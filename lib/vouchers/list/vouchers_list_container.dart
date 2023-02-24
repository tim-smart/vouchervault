import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/vouchers/index.dart';

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

@swidget
Widget _vouchersListContainer(BuildContext context) =>
    AtomBuilder((context, watch, child) {
      final state = watch(vouchersState);

      return VoucherList(
        vouchers: state.sortedVouchers,
        onPressed: (v) => Navigator.push(
          context,
          _DialogRoute(
            (context) => Dismissible(
              key: const Key('VoucherDialogDismissable'),
              direction: DismissDirection.vertical,
              onDismissed: (d) => Navigator.pop(context),
              child: Center(child: VoucherDialogContainer(voucher: v)),
            ),
          ),
        ),
      );
    });
