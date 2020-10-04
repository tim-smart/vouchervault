import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/models/voucher.dart';

class VoucherForm extends StatelessWidget {
  VoucherForm({
    Key key,
    @required this.formKey,
    @required this.initialValue,
  }) : super(key: key);

  final Voucher initialValue;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: initialValue.toJson(),
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}
