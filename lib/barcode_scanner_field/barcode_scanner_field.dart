import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart' show Option;
import 'package:fpdt/option.dart' as O;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' hide Barcode;
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/option.dart';

part 'barcode_scanner_dialog.dart';
part 'barcode_scanner_field.g.dart';
part 'scan_button.dart';

@hwidget
Widget barcodeScannerField(
  BuildContext context, {
  required void Function(String?) onChange,
  required String initialValue,
  required O.Option<Barcode> barcodeType,
  required String labelText,
  O.Option<String> errorText = const O.None(),
  O.Option<void Function(BarcodeFormat)> onScan = const O.None(),
}) {
  final theme = Theme.of(context);
  final controller = useTextEditingController(text: initialValue);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ScanButton(
        barcodeType: barcodeType,
        data: initialValue,
        onScan: (format, data) {
          controller.value = TextEditingValue(
            text: data,
            selection:
                TextSelection.fromPosition(TextPosition(offset: data.length)),
          );
          onChange(data);
          onScan.p(O.map((f) => f(format)));
        },
      ),
      SizedBox(height: AppTheme.space3),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
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
