import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'voucher_spend_dialog.g.dart';

@hwidget
Widget voucherSpendDialog(BuildContext context) {
  final amount = useState('');

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
      onSubmitted: (s) => Navigator.pop(context, s),
    ),
    actions: [
      FlatButton(
        onPressed: () => Navigator.pop(context, null),
        child: Text('Cancel'),
      ),
      FlatButton(
        onPressed: () => Navigator.pop(context, amount.value),
        child: Text('OK'),
      ),
    ],
  );
}
