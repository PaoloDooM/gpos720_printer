///Enum representing available printing modes.
enum PrinterModes { text, image, barcode, barcodeImage, allFunctions }

extension PrinterModesExtension on PrinterModes {
  String get label {
    switch (this) {
      case PrinterModes.text:
        return "text";
      case PrinterModes.image:
        return "image";
      case PrinterModes.barcode:
        return "barcode";
      case PrinterModes.barcodeImage:
        return "barcodeImage";
      case PrinterModes.allFunctions:
        return "allFunctions";
      default:
        throw UnimplementedError("Not implemented.");
    }
  }
}
