import 'package:camera/camera.dart';

class BarcodeScannerStatus {
  BarcodeScannerStatus({
    this.isCameraAvailable = false,
    this.cameraController,
    this.error = "",
    this.barcode = "",
  });

  final bool isCameraAvailable;
  final String error;
  final String barcode;

  factory BarcodeScannerStatus.available(CameraController controller) {
    return BarcodeScannerStatus(
      isCameraAvailable: true,
      cameraController: controller,
    );
  }

  factory BarcodeScannerStatus.error(String message) {
    return BarcodeScannerStatus(
      error: message,
    );
  }

  factory BarcodeScannerStatus.barcode(String barcode) {
    return BarcodeScannerStatus(
      barcode: barcode,
    );
  }

  CameraController? cameraController;

  bool get showCamera => isCameraAvailable && error.isNotEmpty;
  bool get hasError => error.isNotEmpty;
  bool get hasBarcode => barcode.isNotEmpty;
}
