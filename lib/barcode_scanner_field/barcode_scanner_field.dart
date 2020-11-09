import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/option_of_string.dart';

part 'barcode_scanner_field.g.dart';

class BarcodeScannerField extends FormField<String> {
  BarcodeScannerField({
    String labelText = 'Code',
    @required Option<Barcode> Function(BuildContext) barcodeBuilder,
    Option<void Function(BarcodeFormat)> onScan = const None(),
  }) : super(builder: (field) {
          final theme = Theme.of(field.context);
          final barcodeType = barcodeBuilder(field.context);

          return _buildProviders(
            field.value,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<TextEditingController>(
                  builder: (context, controller, child) => _ScanButton(
                    barcodeType,
                    field.value,
                    (r) {
                      controller.value = TextEditingValue(
                        text: r.rawContent,
                        selection: TextSelection.fromPosition(
                            TextPosition(offset: r.rawContent.length)),
                      );
                      field.didChange(r.rawContent);
                      onScan.map((f) => f(r.format));
                    },
                  ),
                ),
                SizedBox(height: AppTheme.space3),
                Consumer<TextEditingController>(
                  builder: (context, controller, child) => TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: labelText,
                    ),
                    onChanged: field.didChange,
                  ),
                ),
                if (field.hasError) ...[
                  SizedBox(height: AppTheme.space2),
                  Text(
                    field.errorText,
                    style: TextStyle(color: theme.errorColor),
                  ),
                ],
              ],
            ),
          );
        });

  static Widget _buildProviders(String initialValue, Widget child) => Provider(
        create: (context) => TextEditingController(text: initialValue),
        dispose: (context, c) => c.dispose(),
        child: child,
      );
}

@swidget
Widget _scanButton(
  BuildContext context,
  Option<Barcode> barcodeType,
  String data,
  void onScan(ScanResult r),
) =>
    FlatButton(
      height: AppTheme.rem(7),
      color: AppColors.lightGrey,
      textColor: Colors.black,
      onPressed: () => BarcodeScanner.scan().then((r) {
        if (r.type != ResultType.Barcode) return;
        onScan(r);
      }),
      child: Center(
        child: Option.map2(
          barcodeType,
          optionOfString(data),
          // ignore: unnecessary_cast
          (Barcode type, String code) => SizedBox(
            height: AppTheme.rem(5),
            child: BarcodeWidget(
              data: code,
              barcode: type,
              errorBuilder: (context, err) => Text('Code not valid'),
            ),
          ) as Widget,
        ).getOrElse(() => Text('Scan barcode')),
      ),
    );
