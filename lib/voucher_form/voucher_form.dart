import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/models/voucher.dart';

class VoucherForm extends StatefulWidget {
  @override
  _VoucherFormState createState() => _VoucherFormState();
}

class _VoucherFormState extends State<VoucherForm> {
  var voucher = Voucher();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (data) => setState(() {
        voucher = Voucher.fromJson(data).copyWith(
          uuid: voucher.uuid,
          code: voucher.code,
        );
      }),
      child: Column(
        children: [
          FormBuilderTextField(
            attribute: 'store',
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Store',
            ),
            validators: [FormBuilderValidators.required()],
          ),
          SizedBox(height: AppTheme.space3),
          FormBuilderTextField(
            attribute: 'description',
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description',
            ),
            validators: [FormBuilderValidators.required()],
          ),
          SizedBox(height: AppTheme.space3),
          FormBuilderDateTimePicker(
            attribute: 'expires',
            inputType: InputType.date,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Expires',
            ),
            valueTransformer: (d) =>
                optionOf<DateTime>(d).map((d) => d.toIso8601String()) | null,
          ),
          SizedBox(height: AppTheme.space3),
          FormBuilderTextField(
            attribute: 'balance',
            keyboardType: TextInputType.numberWithOptions(signed: true),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Balance',
            ),
            valueTransformer: (s) => catching(() => double.parse(s)) | null,
            validators: [
              FormBuilderValidators.numeric(),
              FormBuilderValidators.min(0),
            ],
          ),
          SizedBox(height: AppTheme.space3),
          RaisedButton(
            onPressed: () {
              print(voucher);
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }
}
