enum StatusPrinter {
  impressoraOk,
  semPapel,
  superAquecimento,
  erroDesconhecido
}

extension StatusPrinterExtension on StatusPrinter {
  String getLabel() {
    switch (this) {
      case StatusPrinter.impressoraOk:
        return 'IMPRESSORA OK';
      case StatusPrinter.semPapel:
        return 'SEM PAPEL';
      case StatusPrinter.superAquecimento:
        return 'SUPER AQUECIMENTO';
      case StatusPrinter.erroDesconhecido:
        return 'ERRO DESCONHECIDO';
      default:
        throw UnimplementedError("Not implemented.");
    }
  }

  bool isErrorState() {
    return this != StatusPrinter.impressoraOk;
  }
}

StatusPrinter statusPrinterFromString(String? statusPrinter) {
  return StatusPrinter.values.firstWhere(
          (element) => element.getLabel() == statusPrinter,
      orElse: () => StatusPrinter.erroDesconhecido);
}
