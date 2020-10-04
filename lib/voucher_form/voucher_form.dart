import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/barcode_scanner_field/barcode_scanner_field.dart';
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
          FormBuilderCustomField(
            attribute: 'code',
            formField: BarcodeScannerField(),
            validators: [
              FormBuilderValidators.required(),
            ],
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
          FormBuilderChoiceChip(
            attribute: 'color',
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            alignment: WrapAlignment.spaceAround,
            options: VoucherColor.values
                .map((c) => FormBuilderFieldOption(
                      value: voucherColorValue(c),
                      child: Material(
                        elevation: 2,
                        color: voucherColor(c),
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          height: AppTheme.rem(1.2),
                          width: AppTheme.rem(1.2),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
