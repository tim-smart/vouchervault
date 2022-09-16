import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:intl/intl.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';
import 'package:vouchervault/vouchers/vouchers.dart'
    show Voucher, VoucherCodeType, VoucherColor;
import 'package:vouchervault/vouchers/vouchers.dart' as V;

part 'form.g.dart';

void _updateFieldIfEmpty<T>(
  GlobalKey<FormBuilderState> k,
  String field,
  Option<T> Function() update,
) =>
    O
        .fromNullable(k.currentState!.fields[field])
        .p(O.filter((f) =>
            f.value == null ||
            f.value is! String ||
            (f.value as String).isEmpty))
        .p(O.tap((f) => update().p(O.tap(f.didChange))));

Widget _resetIconButton(
  GlobalKey<FormBuilderState> formKey,
  String field,
) =>
    IconButton(
      onPressed: () => formKey.currentState!.fields[field]?.didChange(null),
      icon: const Icon(Icons.close),
    );

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
        const SizedBox(height: 4),
        FormBuilderTextField(
          name: 'description',
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Description',
          ),
          validator: FormBuilderValidators.required(),
          valueTransformer: optionOfString.c(O.toNullable),
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderField<String>(
          name: 'code',
          valueTransformer: optionOfString.c(O.toNullable),
          validator: FormBuilderValidators.required(),
          builder: (field) => BarcodeScannerField(
            launchScannerImmediately: true,
            labelText: 'Code',
            onChange: field.didChange,
            errorText: optionOfString(field.errorText),
            initialValue: field.value ?? '',
            barcodeType: optionOfString(
                    formKey.currentState!.fields['codeType']?.value)
                .p(O.alt(() => optionOfString(initialFormValue['codeType'])))
                .p(O.flatMap(barcodeFromCodeTypeJson)),
            onScan: O.some((r) {
              O.fromNullable(formKey.currentState!.fields['codeType']).p(O.map(
                  (f) =>
                      f.didChange(codeTypeValueFromFormat(r.barcode.format))));
              _updateFieldIfEmpty(formKey, 'balanceMilliunits',
                  () => r.balance.p(O.map(millisToString)));
              _updateFieldIfEmpty(formKey, 'expires', () => r.expires);
              _updateFieldIfEmpty(formKey, 'description', () => r.merchant);
            }),
          ),
        ),
        FormBuilderChoiceChip(
          name: 'codeType',
          alignment: WrapAlignment.spaceEvenly,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          visualDensity: VisualDensity.compact,
          options: VoucherCodeType.values
              .map((t) => FormBuilderChipOption(
                    value: V.codeTypeToJson(t),
                    child: Text(V.codeTypeLabel(t)),
                  ))
              .toList(),
          validator: FormBuilderValidators.required(),
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderDateTimePicker(
          name: 'expires',
          inputType: InputType.date,
          format: DateFormat('d/M/y'),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
          resetIcon: null,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Expires',
            suffixIcon: _resetIconButton(formKey, 'expires'),
          ),
          valueTransformer: O
              .fromNullableWith<DateTime>()
              .c(O.map((d) => d.toString()))
              .c(O.toNullable),
        ),
        FormBuilderSwitch(
          name: 'removeOnceExpired',
          title: Text(
            'Remove once expired',
            style: theme.textTheme.bodyLarge,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderTextField(
          name: 'balanceMilliunits',
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Balance',
            suffixIcon: _resetIconButton(formKey, 'balanceMilliunits'),
          ),
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderTextField(
          name: 'notes',
          valueTransformer: optionOfString.c(O.toNullable),
          minLines: 2,
          maxLines: null,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Notes',
          ),
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderChoiceChip(
          name: 'color',
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          alignment: WrapAlignment.spaceAround,
          options: VoucherColor.values
              .map((c) => FormBuilderChipOption(
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
