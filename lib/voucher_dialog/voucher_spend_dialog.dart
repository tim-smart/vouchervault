import 'package:flutter/material.dart';

class VoucherSpendDialog extends StatefulWidget {
  @override
  _VoucherSpendDialogState createState() => _VoucherSpendDialogState();
}

class _VoucherSpendDialogState extends State<VoucherSpendDialog> {
  String _amount = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text('How much did you spend?'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Amount',
          ),
          keyboardType: TextInputType.numberWithOptions(signed: true),
          onChanged: (s) => setState(() => _amount = s),
          onSubmitted: (s) => Navigator.pop(context, s),
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text('Cancel'),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context, _amount),
            child: Text('OK'),
          ),
        ],
      );
}
