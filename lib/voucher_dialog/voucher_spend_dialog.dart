import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'voucher_spend_dialog.g.dart';

@hwidget
Widget voucherSpendDialog(BuildContext context) {
  final amount = useState('');
  void submit() => Navigator.pop(context, amount.value);

  return AlertDialog(
    title: Text('How much did you spend?'),
    content: TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Amount',
      ),
      keyboardType: TextInputType.numberWithOptions(signed: true),
      onChanged: (s) => amount.value = s,
      onSubmitted: (s) => submit(),
    ),
    actions: [
      FlatButton(
        onPressed: () => Navigator.pop(context, null),
        child: Text('Cancel'),
      ),
      FlatButton(
        onPressed: submit,
        child: Text('OK'),
      ),
    ],
  );
}
