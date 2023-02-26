import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/lib/navigator.dart';
import 'package:vouchervault/shared/scaffold/scaffold.dart';
import 'package:vouchervault/voucher_form/index.dart';
import 'package:vouchervault/vouchers/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'vouchers_screen.g.dart';

@swidget
Widget _vouchersScreen(BuildContext context) {
  return AppScaffold(
    title: AppLocalizations.of(context)!.vouchers,
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
    floatingActionButton: Option.of(FloatingActionButton(
      onPressed: () => context.runZIO(
        navPush<Voucher>(
          context,
          () => MaterialPageRoute(
            builder: (context) => const VoucherFormDialog(),
            fullscreenDialog: true,
          ),
        ).tap(_createVoucher),
      ),
      child: const Icon(Icons.add),
    )),
  );
}

IO<Unit> _createVoucher(Voucher v) =>
    vouchersLayer.accessWithZIO((_) => _.create(v));
