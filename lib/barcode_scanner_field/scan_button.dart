part of 'barcode_scanner_field.dart';

@swidget
Widget _scanButton(
  BuildContext context, {
  required O.Option<Barcode> barcodeType,
  required String data,
  required void Function(BarcodeFormat, String) onScan,
}) =>
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
        child: tuple2(barcodeType, optionOfString(data))
            .chain(O.mapTuple2((type, code) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppTheme.rem(0.5)),
                  child: SizedBox(
                    height: AppTheme.rem(5),
                    child: BarcodeWidget(
                      data: code,
                      barcode: type,
                      errorBuilder: (context, err) => Text('Code not valid'),
                    ),
                  ),
                ) as Widget))
            .chain(O.alt(
                () => optionOfString(data).chain(O.map((text) => AutoSizeText(
                      text,
                      style: TextStyle(fontSize: 40),
                      maxLines: 1,
                    ) as Widget))))
            .chain(O.getOrElse(() => Text('Scan barcode'))),
      ),
    );
