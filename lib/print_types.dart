enum PrintTypes { texto, imagem, codgigoDeBarra, todasFuncoes }

extension PrintTypesExtension on PrintTypes {
  String getLabel() {
    switch (this) {
      case PrintTypes.texto:
        return "Texto";
      case PrintTypes.imagem:
        return "Imagem";
      case PrintTypes.codgigoDeBarra:
        return "CodigoDeBarra";
      case PrintTypes.todasFuncoes:
        return "TodasFuncoes";
      default:
        throw UnimplementedError("Not implemented.");
    }
  }
}
