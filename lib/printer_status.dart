///An enum to indicate the current status of the printer, it can be parsed to a String using the [getLabel] method.
enum PrinterStatus {
  impressoraOk,
  semPapel,
  superAquecimento,
  erroDesconhecido,
  statusDesconhecido
}

extension PrinterStatusExtension on PrinterStatus {
  String get getLabel {
    switch (this) {
      case PrinterStatus.impressoraOk:
        return 'IMPRESSORA OK';
      case PrinterStatus.semPapel:
        return 'SEM PAPEL';
      case PrinterStatus.superAquecimento:
        return 'SUPER AQUECIMENTO';
      case PrinterStatus.erroDesconhecido:
        return 'ERRO DESCONHECIDO';
      case PrinterStatus.statusDesconhecido:
        return 'STATUS DESCONHECIDO';
      default:
        throw UnimplementedError("Not implemented.");
    }
  }

  bool get isImpressoraOK {
    return this != PrinterStatus.impressoraOk;
  }
}
