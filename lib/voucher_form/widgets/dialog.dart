import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/shared/scaffold/app_scaffold.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';
import 'package:vouchervault/vouchers/vouchers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'dialog.g.dart';

@hwidget
Widget _voucherFormDialog(
  BuildContext context, {
  Option<Voucher> initialValue = const None(),
}) {
  final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
  final title = initialValue.p(O.fold(
    () => AppLocalizations.of(context)!.addVoucher,
    (_) => AppLocalizations.of(context)!.editVoucher,
  ));
  final action = initialValue.p(O.fold(
    () => AppLocalizations.of(context)!.create,
    (_) => AppLocalizations.of(context)!.update,
  ));

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
            initialValue: initialValue.p(O.getOrElse(() => Voucher())),
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(
          bottom: AppTheme.space5,
          left: AppTheme.space4,
          right: AppTheme.space4,
          top: AppTheme.space3,
        ),
        sliver: SliverToBoxAdapter(
          child: ElevatedButton(
            child: Text(action),
            onPressed: () {
              if (formKey.currentState!.saveAndValidate()) {
                final voucher =
                    Voucher.fromFormValue(formKey.currentState!.value);

                Navigator.pop(
                  context,
                  initialValue.p(O.fold(
                    () => voucher,
                    (iv) => voucher.copyWith(uuid: iv.uuid),
                  )),
                );
              }
            },
          ),
        ),
      ),
    ],
  );
}
