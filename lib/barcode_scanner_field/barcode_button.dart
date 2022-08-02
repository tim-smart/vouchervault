// ignore_for_file: unnecessary_cast

part of 'barcode_scanner_field.dart';

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
Widget __barcodeButton(
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
