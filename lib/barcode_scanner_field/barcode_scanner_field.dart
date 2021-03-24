import 'package:barcode_widget/barcode_widget.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' hide Barcode;
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/barcode_scanner_field/barcode_scanner_dialog.dart';
import 'package:vouchervault/lib/option_of_string.dart';

part 'barcode_scanner_field.g.dart';

class BarcodeScannerField extends FormBuilderField<String> {
  BarcodeScannerField({
    required String name,
    String labelText = 'Code',
    required Option<Barcode> Function(BuildContext) barcodeBuilder,
    Option<void Function(BarcodeFormat)> onScan = const None(),
    required dynamic Function(String) valueTransformer,
  }) : super(
          name: name,
          valueTransformer: valueTransformer,
          builder: (field) {
            final theme = Theme.of(field.context);
            final barcodeType = barcodeBuilder(field.context);

            return _buildProviders(
              field.value ?? '',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<TextEditingController>(
                    builder: (context, controller, child) => _ScanButton(
                      barcodeType,
                      field.value ?? '',
                      (format, data) {
                        controller.value = TextEditingValue(
                          text: data,
                          selection: TextSelection.fromPosition(
                              TextPosition(offset: data.length)),
                        );
                        field.didChange(data);
                        onScan.map((f) => f(format));
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
                      field.errorText ?? '',
                      style: TextStyle(color: theme.errorColor),
                    ),
                  ],
                ],
              ),
            );
          },
        );

  static Widget _buildProviders(String initialValue, Widget child) =>
      Provider<TextEditingController>(
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
  void onScan(BarcodeFormat, String),
) =>
    TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.lightGrey,
        primary: Colors.black,
        minimumSize: Size.fromHeight(AppTheme.rem(7)),
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BarcodeScannerDialog(
            onScan: (format, data) {
              onScan(format, data);
              Navigator.of(context).pop();
            },
          ),
          fullscreenDialog: true,
        ));
      },
      child: Center(
        child: Option.map2(
          barcodeType,
          optionOfString(data),
          // ignore: unnecessary_cast
          (Barcode type, String code) => Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.rem(0.5)),
            child: SizedBox(
              height: AppTheme.rem(5),
              child: BarcodeWidget(
                data: code,
                barcode: type,
                errorBuilder: (context, err) => Text('Code not valid'),
              ),
            ),
          ) as Widget,
        ).getOrElse(() => Text('Scan barcode')),
      ),
    );
