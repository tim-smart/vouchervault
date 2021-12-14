part of 'barcode_scanner_field.dart';

final _key = GlobalKey(debugLabel: "QR");

ValueNotifier<O.Option<QRViewController>> _useController() {
  final controller = useState<O.Option<QRViewController>>(O.none());

  useEffect(() {
    return controller.value.chain(O.fold(
      () => () {},
      (c) => c.dispose,
    ));
  }, [controller.value]);

  return controller;
}

@hwidget
Widget barcodeScannerDialog(
  BuildContext context, {
  required void Function(BarcodeFormat, String) onScan,
}) {
  final controller = _useController();

  useEffect(() {
    return controller.value.chain(O.fold(
      () => () {},
      (c) => c.scannedDataStream
          .where((d) => d.code != null)
          .take(1)
          .listen((data) {
        onScan(data.format, data.code!);
      }).cancel,
    ));
  }, [controller.value, onScan]);

  return AnnotatedRegion(
    value: SystemUiOverlayStyle.light,
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: QRView(
              key: _key,
              overlay: QrScannerOverlayShape(
                borderLength: 50,
                borderRadius: 10,
                borderWidth: 15,
                cutOutSize: 300,
              ),
              onQRViewCreated: (c) => controller.value = O.some(c),
              // formatsAllowed: BarcodeFormat.values,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              bottom: true,
              child: Padding(
                padding: EdgeInsets.all(AppTheme.space3),
                child: Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        controller.value.chain(O.map((c) => c.toggleFlash()));
                      },
                      child: Text('Toggle flash'),
                    ),
                    SizedBox(width: AppTheme.space3),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
