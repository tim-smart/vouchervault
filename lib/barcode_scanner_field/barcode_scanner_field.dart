import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_widget/barcode_widget.dart' show Barcode, BarcodeWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/task_either.dart' as TE;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:mobile_scanner/mobile_scanner.dart' hide Barcode;
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/files.dart';
import 'package:vouchervault/lib/option.dart';

part 'barcode_scanner_dialog.dart';
part 'barcode_scanner_field.g.dart';
part 'scan_button.dart';

@hwidget
Widget _barcodeScannerField(
  BuildContext context, {
  required void Function(String) onChange,
  required String initialValue,
  required Option<Barcode> barcodeType,
  required String labelText,
  Option<String> errorText = const None(),
  Option<void Function(BarcodeFormat)> onScan = const None(),
}) {
  final theme = Theme.of(context);
  final controller = useTextEditingController(text: initialValue);
  final setText = useCallback(
    (String data) => controller.value = TextEditingValue(
      text: data,
      selection: TextSelection.fromPosition(TextPosition(offset: data.length)),
    ),
    [controller],
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ScanButton(
        barcodeType: barcodeType,
        data: initialValue,
        onScan: (format, data) {
          setText(data);
          onChange(data);
          onScan.p(O.map((f) => f(format)));
        },
      ),
      SizedBox(height: AppTheme.space3),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
        onChanged: onChange,
      ),
      ...errorText.p(O.fold(
        () => [],
        (error) => [
          SizedBox(height: AppTheme.space2),
          Text(
            error,
            style: TextStyle(color: theme.errorColor),
          ),
        ],
      )),
    ],
  );
}
