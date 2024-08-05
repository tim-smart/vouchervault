import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/voucher_form/index.dart';

part 'barcode_scanner_field.g.dart';

@hwidget
Widget _barcodeScannerField(
  BuildContext context, {
  required void Function(String) onChange,
  required String initialValue,
  required Option<Barcode> barcodeType,
  required String labelText,
  Option<String> errorText = const Option.none(),
  required void Function(BarcodeResult r) onScan,
  bool launchScannerImmediately = false,
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

  final showDialog = useCallback(() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ScannerDialog(
        onScan: (r) {
          setText(r.barcode.rawValue!);
          onChange(r.barcode.rawValue!);
          onScan(r);
          Navigator.of(context).pop();
        },
      ),
      fullscreenDialog: true,
    ));
  }, [context, setText, onChange, onScan]);

  useEffect(() {
    if (launchScannerImmediately && initialValue.isEmpty) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        showDialog();
      });
    }
    return null;
  }, []);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      BarcodeButton(
        barcodeType: barcodeType,
        data: initialValue,
        onPressed: showDialog,
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
      ...errorText.match(
        () => [],
        (error) => [
          SizedBox(height: AppTheme.space2),
          Text(
            error,
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ],
      ),
    ],
  );
}
