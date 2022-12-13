import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'voucher_spend_dialog.g.dart';

@hwidget
Widget _voucherSpendDialog(BuildContext context) {
  final amount = useValueNotifier('');
  void submit() => Navigator.pop(context, amount.value);

  return AlertDialog(
    title: Text(AppLocalizations.of(context)!.howMuchSpend),
    content: TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: AppLocalizations.of(context)!.amount,
      ),
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      onChanged: (s) => amount.value = s,
      onSubmitted: (s) => submit(),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, null),
        child: Text(AppLocalizations.of(context)!.cancel),
      ),
      TextButton(
        onPressed: submit,
        child: Text(AppLocalizations.of(context)!.ok),
      ),
    ],
  );
}
