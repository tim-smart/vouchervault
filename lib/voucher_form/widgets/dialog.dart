import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/shared/scaffold/app_scaffold.dart';
import 'package:vouchervault/voucher_form/index.dart';
import 'package:vouchervault/vouchers/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'dialog.g.dart';

@hwidget
Widget _voucherFormDialog(
  BuildContext context, {
  Option<Voucher> initialValue = const Option.none(),
}) {
  final theme = Theme.of(context);
  final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
  final title = initialValue.match(
    () => AppLocalizations.of(context)!.addVoucher,
    (_) => AppLocalizations.of(context)!.editVoucher,
  );
  final action = initialValue.match(
    () => AppLocalizations.of(context)!.create,
    (_) => AppLocalizations.of(context)!.update,
  );

  return AppScaffold(
    leading: true,
    title: title,
    slivers: [
      SliverPadding(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.space4,
        ),
        sliver: SliverToBoxAdapter(
          child: VoucherForm(
            formKey: formKey,
            initialValue: initialValue.getOrElse(() => Voucher()),
          ),
        ),
      ),
      SliverSafeArea(
        bottom: true,
        top: false,
        sliver: SliverPadding(
          padding: EdgeInsets.only(
            bottom: AppTheme.space5,
            left: AppTheme.space4,
            right: AppTheme.space4,
            top: AppTheme.space3,
          ),
          sliver: SliverToBoxAdapter(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: theme.colorScheme.onPrimary,
                backgroundColor: theme.colorScheme.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.space3,
                  vertical: AppTheme.space3,
                ),
                textStyle: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text(action),
              onPressed: () {
                if (formKey.currentState!.saveAndValidate()) {
                  final voucher = Voucher.fromFormValue(
                    formKey.currentState!.value,
                  );

                  Navigator.pop(
                    context,
                    initialValue.match(
                      () => voucher,
                      (iv) => voucher.copyWith(uuid: iv.uuid),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    ],
  );
}
