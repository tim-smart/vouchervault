import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:intl/intl.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/barcode_scanner_field/barcode_scanner_field.dart';
import 'package:vouchervault/models/voucher.dart'
    show Voucher, VoucherCodeType, VoucherColor;
import 'package:vouchervault/models/voucher.dart' as V;
import 'package:vouchervault/lib/barcode.dart' as barcode;

part 'voucher_form.g.dart';

@swidget
Widget voucherForm(
  BuildContext context, {
  @required GlobalKey<FormBuilderState> formKey,
  @required Voucher initialValue,
}) {
  final theme = Theme.of(context);
  final initialFormValue = initialValue.toFormValue();

  return FormBuilder(
    key: formKey,
    initialValue: initialFormValue,
    child: Column(
      children: [
        SizedBox(height: AppTheme.space1),
        FormBuilderTextField(
          autofocus: true,
          attribute: 'description',
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Description',
          ),
          validators: [FormBuilderValidators.required()],
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderCustomField(
          attribute: 'code',
          formField: BarcodeScannerField(
            labelText: 'Code',
            barcodeBuilder: (context) =>
                optionOf(formKey.currentState.fields['codeType'])
                    .map((f) => f.currentState.value as String)
                    .orElse(() => optionOf(initialFormValue['codeType']))
                    .bind(barcode.fromCodeTypeJson),
            onScan: some((f) =>
                optionOf(formKey.currentState.fields['codeType'])
                    .map((f) => f.currentState.didChange)
                    .map((didChange) =>
                        didChange(barcode.codeTypeValueFromFormat(f)))),
          ),
          valueTransformer: (s) =>
              optionOf(s as String).bind((s) => s.isEmpty ? none() : some(s)) |
              null,
        ),
        FormBuilderChoiceChip(
          attribute: 'codeType',
          alignment: WrapAlignment.spaceAround,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          options: VoucherCodeType.values
              .map((t) => FormBuilderFieldOption(
                    value: V.codeTypeToJson(t),
                    child: Text(V.codeTypeLabel(t),
                        style: theme.textTheme.bodyText2.copyWith(
                          fontSize: AppTheme.rem(0.8),
                        )),
                  ))
              .toList(),
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
          format: DateFormat('d/M/y'),
          valueTransformer: (d) => optionOf(d).map((d) => d.toString()) | null,
        ),
        FormBuilderSwitch(
          attribute: 'removeOnceExpired',
          label: Text(
            'Remove once expired',
            style: theme.textTheme.bodyText1,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderCustomField<double>(
          attribute: 'balance',
          formField: FormField<double>(
            builder: (field) => TextFormField(
              initialValue: optionOf(field.value).map((d) => d.toString()) | '',
              onChanged: (s) =>
                  field.didChange(s.isEmpty ? null : double.parse(s)),
              keyboardType: TextInputType.numberWithOptions(signed: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Balance',
              ),
            ),
          ),
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
                    value: V.colorToJson(c),
                    child: Material(
                      elevation: 2,
                      color: V.color(c),
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
