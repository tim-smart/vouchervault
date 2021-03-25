part of 'barcode_scanner_field.dart';

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
