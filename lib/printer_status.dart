///An enum to indicate the current status of the printer. The `isPrinterOk` getter returns `true` only if the printer is functioning properly without any issues.
enum PrinterStatus {
  printerOk,
  outOfPaper,
  overheat,
  unknownError,
  unknownStatus
}

extension PrinterStatusExtension on PrinterStatus {
  String get label {
    switch (this) {
      case PrinterStatus.printerOk:
        return 'printerOk';
      case PrinterStatus.outOfPaper:
        return 'outOfPaper';
      case PrinterStatus.overheat:
        return 'overheat';
      case PrinterStatus.unknownError:
        return 'unknownError';
      case PrinterStatus.unknownStatus:
        return 'unknownStatus';
      default:
        throw UnimplementedError("Not implemented.");
    }
  }

  bool get isPrinterOk {
    return this == PrinterStatus.printerOk;
  }
}
