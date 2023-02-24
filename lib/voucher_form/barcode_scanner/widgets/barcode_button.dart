// ignore_for_file: unnecessary_cast
import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'barcode_button.g.dart';

Option<Widget> _barcodeWidget(Option<Barcode> type, Option<String> code) =>
    type.map2(
      code,
      (type, String code) => Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.rem(0.5)),
        child: SizedBox(
          height: AppTheme.rem(5),
          child: BarcodeWidget(
            data: code,
            barcode: type,
            errorBuilder: (context, err) => const Text('Code not valid'),
          ),
        ),
      ),
    );

Option<Widget> _autoSizeText(String text) =>
    optionOfString(text).map((text) => AutoSizeText(
          text,
          style: const TextStyle(fontSize: 40),
          maxLines: 1,
        ) as Widget);

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
        foregroundColor: Colors.black,
        minimumSize: Size.fromHeight(AppTheme.rem(7)),
      ),
      onPressed: onPressed,
      child: Center(
        child: _barcodeWidget(barcodeType, optionOfString(data))
            .alt(() => _autoSizeText(data))
            .getOrElse(
              () => Text(AppLocalizations.of(context)!.scanBarcode),
            ),
      ),
    );
