import 'package:freezed_annotation/freezed_annotation.dart';

part 'ml_error.freezed.dart';

@freezed
class MlError with _$MlError {
  const MlError._();

  const factory MlError.barcodeNotFound() = _MlErrorBarcodeNotFound;
  const factory MlError.pickerError(String message) = _MlErrorPicker;
  const factory MlError.mlkitError({
    required String op,
    required dynamic err,
  }) = _MlErrorMlKit;

  String get friendlyMessage => when(
        barcodeNotFound: () => 'Could not find a barcode',
        pickerError: (msg) => 'Could not load image: $msg',
        mlkitError: (op, err) => 'Could not process image in method: $op',
      );
}
