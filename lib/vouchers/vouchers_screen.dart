import 'package:flutter/material.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/shared/scaffold/scaffold.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

part 'vouchers_screen.g.dart';

final _maybeAddVoucher =
    (RefRead read) => O.fromNullableWith<Voucher>().c(O.map(create)).c(O.fold(
          () => Future.value(),
          read(vouchersSMProvider).evaluate,
        ));

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
        onPressed: () {
          Navigator.push<Voucher>(
            context,
            MaterialPageRoute(
              builder: (context) => const VoucherFormDialog(),
              fullscreenDialog: true,
            ),
          ).then(_maybeAddVoucher(ref.read));
        },
        child: const Icon(Icons.add),
      )),
    );
