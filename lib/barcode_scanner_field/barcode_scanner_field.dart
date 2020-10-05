import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vouchervault/app/app.dart';

class BarcodeScannerField extends FormField<String> {
  BarcodeScannerField({
    String labelText = 'Code',
  }) : super(
          builder: (field) {
            final theme = Theme.of(field.context);
            return _buildProviders(
              field.value,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<TextEditingController>(
                    builder: (context, controller, child) => _buildScanButton(
                      field.context,
                      field.value,
                      (s) {
                        controller.value = TextEditingValue(
                          text: s,
                          selection: TextSelection.fromPosition(
                              TextPosition(offset: s.length)),
                        );
                        field.didChange(s);
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
          },
        );

  static Widget _buildProviders(String initialValue, Widget child) => Provider(
        create: (context) => TextEditingController(text: initialValue),
        dispose: (context, c) => c.dispose(),
        child: child,
      );

  static Widget _buildScanButton(
          BuildContext context, String data, void didChange(String s)) =>
      FlatButton(
        height: AppTheme.rem(7),
        color: AppColors.lightGrey,
        textColor: Colors.black,
        onPressed: () => BarcodeScanner.scan().then((r) {
          if (r.type != ResultType.Barcode) return;
          didChange(r.rawContent);
        }),
        child: Center(
          child: optionOf(data).bind((s) => s.isEmpty ? none() : some(s)).fold(
                () => Text('Scan barcode'),
                (code) => SizedBox(
                  height: AppTheme.rem(5),
                  child: BarcodeWidget(
                    data: code,
                    barcode: Barcode.code128(),
                  ),
                ),
              ),
        ),
      );
}
