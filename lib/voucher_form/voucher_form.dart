import 'package:dartz/dartz.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:intl/intl.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/barcode_scanner_field/barcode_scanner_field.dart';
import 'package:vouchervault/lib/barcode.dart' as barcode;
import 'package:vouchervault/models/voucher.dart'
    show Voucher, VoucherCodeType, VoucherColor;
import 'package:vouchervault/models/voucher.dart' as V;

part 'voucher_form.g.dart';

@swidget
Widget voucherForm(
  BuildContext context, {
  required GlobalKey<FormBuilderState> formKey,
  required Voucher initialValue,
}) {
  final theme = Theme.of(context);
  final initialFormValue = initialValue.toFormValue();

  return FormBuilder(
    key: formKey,
    initialValue: initialFormValue,
    child: Column(
      children: [
        SizedBox(height: 3),
        FormBuilderTextField(
          autofocus: true,
          name: 'description',
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Description',
          ),
          validator: FormBuilderValidators.required(context),
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderField<String>(
          name: 'code',
          valueTransformer: (String? s) => optionOf(s)
              .bind((s) => s.isEmpty ? none() : some(s))
              .toNullable(),
          validator: FormBuilderValidators.required(context),
          builder: (field) => BarcodeScannerField(
            labelText: 'Code',
            onChange: field.didChange,
            errorText: optionOf(field.errorText),
            initialValue: field.value ?? '',
            barcodeType: optionOf(formKey.currentState!.fields['codeType'])
                .map<String>((f) => f.value)
                .orElse(() => optionOf(initialFormValue['codeType']))
                .bind(barcode.fromCodeTypeJson),
            onScan: some((f) =>
                optionOf(formKey.currentState!.fields['codeType'])
                    .map((f) => f.didChange)
                    .map((didChange) =>
                        didChange(barcode.codeTypeValueFromFormat(f)))),
          ),
        ),
        FormBuilderChoiceChip(
          name: 'codeType',
          alignment: WrapAlignment.spaceAround,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          visualDensity: VisualDensity.compact,
          options: VoucherCodeType.values
              .map((t) => FormBuilderFieldOption(
                    value: V.codeTypeToJson(t),
                    child: Text(V.codeTypeLabel(t)),
                  ))
              .toList(),
          validator: FormBuilderValidators.required(context),
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderField<DateTime>(
          name: 'expires',
          builder: (field) => DateTimeField(
            initialValue: field.value,
            format: DateFormat('d/M/y'),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Expires',
            ),
            onChanged: (d) {
              field.didChange(d);
            },
            onShowPicker: (context, d) => showDatePicker(
              context: context,
              initialDate: d ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365 * 100)),
            ),
          ),
          valueTransformer: (DateTime? d) =>
              optionOf(d).map((d) => d.toString()).toNullable(),
        ),
        FormBuilderSwitch(
          name: 'removeOnceExpired',
          title: Text(
            'Remove once expired',
            style: theme.textTheme.bodyText1,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderField<double>(
          name: 'balance',
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
        SizedBox(height: AppTheme.space3),
        FormBuilderChoiceChip(
          name: 'color',
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
