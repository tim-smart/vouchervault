import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:intl/intl.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/voucher_form/index.dart';
import 'package:vouchervault/vouchers/index.dart'
    show Voucher, VoucherCodeType, VoucherColor;
import 'package:vouchervault/vouchers/index.dart' as V;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'form.g.dart';

IOOption<Unit> _updateFieldIfEmpty<T>(
  GlobalKey<FormBuilderState> k,
  String field,
  IOOption<T> update,
) =>
    IOOption.fromNullable(k.currentState!.fields[field])
        .filter((f) =>
            f.value == null ||
            f.value is! String ||
            (f.value as String).isEmpty)
        .zip(update)
        .tap((t) => ZIO(() => t.$1.didChange(t.$2)))
        .asUnit;

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
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: AppLocalizations.of(context)!.description,
          ),
          validator: FormBuilderValidators.required(),
          valueTransformer: (_) => optionOfString(_).toNullable(),
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderField<String>(
          name: 'code',
          valueTransformer: (_) => optionOfString(_).toNullable(),
          validator: FormBuilderValidators.required(),
          builder: (field) => BarcodeScannerField(
            launchScannerImmediately: true,
            labelText: AppLocalizations.of(context)!.code,
            onChange: field.didChange,
            errorText: optionOfString(field.errorText),
            initialValue: field.value ?? '',
            barcodeType:
                optionOfString(formKey.currentState!.fields['codeType']?.value)
                    .alt(() => optionOfString(initialFormValue['codeType']))
                    .flatMap(barcodeFromCodeTypeJson),
            onScan: (r) {
              [
                IOOption.fromNullable(
                  formKey.currentState!.fields['codeType'],
                ).tap(
                  (_) => ZIO(() =>
                      _.didChange(codeTypeValueFromFormat(r.barcode.format))),
                ),
                _updateFieldIfEmpty(
                  formKey,
                  'balanceMilliunits',
                  r.balance.map(millisToString).toZIO,
                ),
                _updateFieldIfEmpty(
                  formKey,
                  'expires',
                  r.expires.toZIO,
                ),
                _updateFieldIfEmpty(
                  formKey,
                  'description',
                  r.merchant.toZIO,
                ),
              ].collectDiscard.runContext(context);
            },
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
                    avatar: null,
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
            labelText: AppLocalizations.of(context)!.expires,
            suffixIcon: _resetIconButton(formKey, 'expires'),
          ),
          valueTransformer: (_) =>
              Option.fromNullable(_).map((d) => d.toString()).toNullable(),
        ),
        FormBuilderSwitch(
          name: 'removeOnceExpired',
          title: Text(
            AppLocalizations.of(context)!.removeOnceExpired,
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
            labelText: AppLocalizations.of(context)!.balance,
            suffixIcon: _resetIconButton(formKey, 'balanceMilliunits'),
          ),
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderTextField(
          name: 'notes',
          valueTransformer: (_) => optionOfString(_).toNullable(),
          minLines: 2,
          maxLines: null,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: AppLocalizations.of(context)!.notes,
          ),
        ),
        SizedBox(height: AppTheme.space3),
        FormBuilderChoiceChip(
          name: 'color',
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          alignment: WrapAlignment.spaceAround,
          padding: EdgeInsets.zero,
          options: VoucherColor.values
              .map(
                (c) => FormBuilderChipOption(
                  avatar: null,
                  value: V.colorToJson(c),
                  child: Material(
                    elevation: 2,
                    color: V.color(c),
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      height: AppTheme.rem(1.1),
                      width: AppTheme.rem(1.1),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}
