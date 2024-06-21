enum PrintTypes {
  texto,
  imagem,
  codgigoDeBarra,
  codgigoDeBarraImg,
  todasFuncoes
}

extension PrintTypesExtension on PrintTypes {
  String get getLabel {
    switch (this) {
      case PrintTypes.texto:
        return "Texto";
      case PrintTypes.imagem:
        return "Imagem";
      case PrintTypes.codgigoDeBarra:
        return "CodigoDeBarra";
      case PrintTypes.codgigoDeBarraImg:
        return "CodigoDeBarraImg";
      case PrintTypes.todasFuncoes:
        return "TodasFuncoes";
      default:
        throw UnimplementedError("Not implemented.");
    }
  }
}
