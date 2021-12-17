import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'voucher_spend_dialog.g.dart';

final _amountProvider = StateProvider.autoDispose((ref) => '');

@cwidget
Widget voucherSpendDialog(BuildContext context, WidgetRef ref) {
  final amount = ref.watch(_amountProvider.notifier);
  void submit() => Navigator.pop(context, amount.state);

  return AlertDialog(
    title: Text('How much did you spend?'),
    content: TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Amount',
      ),
      keyboardType: TextInputType.numberWithOptions(signed: true),
      onChanged: (s) => amount.state = s,
      onSubmitted: (s) => submit(),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, null),
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: submit,
        child: Text('OK'),
      ),
    ],
  );
}
