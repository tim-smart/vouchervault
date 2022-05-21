part of 'barcode_scanner_field.dart';

final _key = GlobalKey(debugLabel: "QR");

MobileScannerController _useController() {
  final controller = useMemoized(() => MobileScannerController(), []);
  useEffect(() => controller.dispose, [controller]);
  return controller;
}

TaskEither<String, void> _chooseImage(MobileScannerController controller) =>
    pickImage()
        .p(TE.chainNullableK((file) => file.path, (_) => 'file path not found'))
        .p(
          TE.chainTryCatchK((file) => controller.analyzeImage(file),
              (err, stackTrace) => 'analyzeImage err: $err'),
        );

@hwidget
Widget barcodeScannerDialog(
  BuildContext context, {
  required void Function(BarcodeFormat, String) onScan,
}) {
  final controller = _useController();

  return AnnotatedRegion(
    value: SystemUiOverlayStyle.light,
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: MobileScanner(
              key: _key,
              controller: controller,
              onDetect: (barcode, args) {
                if (barcode.rawValue != null) {
                  onScan(barcode.format, barcode.rawValue!);
                }
              },
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
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add_photo_alternate),
                      onPressed: () {
                        _chooseImage(controller)();
                      },
                    ),
                    SizedBox(width: AppTheme.space3),
                    ElevatedButton(
                      onPressed: () {
                        controller.toggleTorch();
                      },
                      child: const Text('Toggle flash'),
                    ),
                    SizedBox(width: AppTheme.space3),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
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
