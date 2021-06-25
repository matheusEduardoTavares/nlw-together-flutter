import 'package:camera/camera.dart';

class BarcodeScannerStatus {
  BarcodeScannerStatus({
    this.isCameraAvailable = false,
    this.error = "",
    this.barcode = "",
    this.stopScanner = false,
  });

  final bool isCameraAvailable;
  final String error;
  final String barcode;
  final bool stopScanner;

  factory BarcodeScannerStatus.available() {
    return BarcodeScannerStatus(
      isCameraAvailable: true,
      stopScanner: false,
    );
  }

  factory BarcodeScannerStatus.error(String message) {
    return BarcodeScannerStatus(
      error: message,
      stopScanner: true,
    );
  }

  factory BarcodeScannerStatus.barcode(String barcode) {
    return BarcodeScannerStatus(
      barcode: barcode,
      stopScanner: true,
    );
  }

  CameraController? cameraController;

  bool get showCamera => isCameraAvailable && error.isEmpty;
  bool get hasError => error.isNotEmpty;
  bool get hasBarcode => barcode.isNotEmpty;
}
