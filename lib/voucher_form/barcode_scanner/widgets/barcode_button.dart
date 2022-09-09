// ignore_for_file: unnecessary_cast
import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/lib.dart';

part 'barcode_button.g.dart';

final _barcodeWidget = O.map2((Barcode type, String code) => Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.rem(0.5)),
      child: SizedBox(
        height: AppTheme.rem(5),
        child: BarcodeWidget(
          data: code,
          barcode: type,
          errorBuilder: (context, err) => const Text('Code not valid'),
        ),
      ),
    ) as Widget);

final _autoSizeText = optionOfString.c(O.map((text) => AutoSizeText(
      text,
      style: const TextStyle(fontSize: 40),
      maxLines: 1,
    ) as Widget));

@swidget
Widget _barcodeButton(
  BuildContext context, {
  required Option<Barcode> barcodeType,
  required String data,
  required void Function() onPressed,
}) =>
    TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.lightGrey,
        primary: Colors.black,
        minimumSize: Size.fromHeight(AppTheme.rem(7)),
      ),
      onPressed: onPressed,
      child: Center(
        child: _barcodeWidget(barcodeType, optionOfString(data))
            .p(O.alt(() => _autoSizeText(data)))
            .p(O.getOrElse(() => const Text('Scan barcode'))),
      ),
    );
