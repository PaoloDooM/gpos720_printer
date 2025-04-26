///An enum to indicate the current status of the printer, it can be parsed to a String using the [message] getter.
enum PrinterStatus {
  printerOk,
  outOfPaper,
  overheat,
  unknownError,
  unknownStatus
}

extension PrinterStatusExtension on PrinterStatus {
  String get message {
    switch (this) {
      case PrinterStatus.printerOk:
        return 'Printer OK';
      case PrinterStatus.outOfPaper:
        return 'Out of paper';
      case PrinterStatus.overheat:
        return 'Overheat';
      case PrinterStatus.unknownError:
        return 'Unknown error';
      case PrinterStatus.unknownStatus:
        return 'Unknown status';
      default:
        throw UnimplementedError("Not implemented.");
    }
  }

  bool get isPrinterOk {
    return this ==
        PrinterStatus.printerOk; // Checks if the status is "printerOk"
  }
}
