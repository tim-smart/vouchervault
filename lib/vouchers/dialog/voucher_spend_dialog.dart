import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'voucher_spend_dialog.g.dart';

@hwidget
Widget _voucherSpendDialog(BuildContext context) {
  final amount = useValueNotifier('');
  void submit() => Navigator.pop(context, amount.value);

  return AlertDialog(
    title: const Text('How much did you spend?'),
    content: TextField(
      autofocus: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Amount',
      ),
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      onChanged: (s) => amount.value = s,
      onSubmitted: (s) => submit(),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, null),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: submit,
        child: const Text('OK'),
      ),
    ],
  );
}
