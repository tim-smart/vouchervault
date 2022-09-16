// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_button.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class BarcodeButton extends StatelessWidget {
  const BarcodeButton({
    Key? key,
    required this.barcodeType,
    required this.data,
    required this.onPressed,
  }) : super(key: key);

  final Option<Barcode> barcodeType;

  final String data;

  final void Function() onPressed;

  @override
  Widget build(BuildContext _context) => _barcodeButton(
        _context,
        barcodeType: barcodeType,
        data: data,
        onPressed: onPressed,
      );
}
