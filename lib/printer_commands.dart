///Enum representing available printer commands.
enum PrinterCommands {
  getPlatformVersion,
  checkPrinter,
  endPrinting,
  lineFeed,
  print
}

extension PrinterCommandsExtension on PrinterCommands {
  String get label {
    switch (this) {
      case PrinterCommands.getPlatformVersion:
        return "getPlatformVersion";
      case PrinterCommands.checkPrinter:
        return "checkPrinter";
      case PrinterCommands.endPrinting:
        return "endPrinting";
      case PrinterCommands.lineFeed:
        return "lineFeed";
      case PrinterCommands.print:
        return "print";
      default:
        throw UnimplementedError("Not implemented.");
    }
  }
}
