import 'package:flutter/material.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/task_option.dart' as TO;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/lib/navigator.dart';
import 'package:vouchervault/shared/scaffold/scaffold.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

part 'vouchers_screen.g.dart';

@cwidget
Widget _vouchersScreen(BuildContext context, WidgetRef ref) => AppScaffold(
      title: 'Vouchers',
      actions: const [VouchersMenuContainer()],
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(
            top: AppTheme.rem(1.5),
            bottom: AppTheme.space6,
          ),
          sliver: const VouchersListContainer(),
        ),
      ],
      floatingActionButton: O.some(FloatingActionButton(
        onPressed: navPush<Voucher>(
          context,
          () => MaterialPageRoute(
            builder: (context) => const VoucherFormDialog(),
            fullscreenDialog: true,
          ),
        ).p(TO.tap(_createVoucher(ref.read))),
        child: const Icon(Icons.add),
      )),
    );

void Function(Voucher) _createVoucher(RefRead read) =>
    (v) => read(vouchersSMProvider).run(create(v));
