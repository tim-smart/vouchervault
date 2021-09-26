part of 'barcode_scanner_field.dart';

final _key = GlobalKey(debugLabel: "QR");

ValueNotifier<Option<QRViewController>> _useController() {
  final controller = useState<Option<QRViewController>>(none());

  useEffect(() {
    return controller.value.match(
      (c) => c.dispose,
      () => () {},
    );
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
    return controller.value.match(
      (c) {
        final sub = c.scannedDataStream.take(1).listen((data) {
          onScan(data.format, data.code);
        });
        return sub.cancel;
      },
      () => () {},
    );
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
              onQRViewCreated: (c) => controller.value = some(c),
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
                        controller.value.map((c) => c.toggleFlash());
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
