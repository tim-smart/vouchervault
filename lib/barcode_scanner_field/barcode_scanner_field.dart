import 'package:barcode_widget/barcode_widget.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:vouchervault/app/app.dart';

class BarcodeScannerField extends FormField<String> {
  BarcodeScannerField()
      : super(
          builder: (field) {
            final theme = Theme.of(field.context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton(
                  height: AppTheme.rem(7),
                  color: AppColors.lightGrey,
                  textColor: Colors.black,
                  onPressed: () => FlutterBarcodeScanner.scanBarcode(
                    Colors.red.toString(),
                    'Cancel',
                    true,
                    ScanMode.DEFAULT,
                  ).then(field.didChange),
                  child: Center(
                    child: optionOf(field.value)
                        .bind((s) => s.isEmpty ? none() : some(s))
                        .fold(
                          () => Text('Scan barcode'),
                          (code) => BarcodeWidget(
                            data: code,
                            barcode: Barcode.code128(),
                          ),
                        ),
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
            );
          },
        );
}
