enum BarcodeTypes {
  aztec,
  codabar,
  code39,
  code93,
  code128,
  dataMatrix,
  ean8,
  ean13,
  itf,
  maxicode,
  pdf417,
  qrCode,
  rss14,
  rssExpanded,
  upcA,
  upcE,
  upcEanExtension
}

extension BarcodeTypesExtension on BarcodeTypes {
  String getLabel() {
    switch (this) {
      case BarcodeTypes.aztec:
        return "AZTEC";
      case BarcodeTypes.codabar:
        return "CODABAR";
      case BarcodeTypes.code39:
        return "CODE_39";
      case BarcodeTypes.code93:
        return "CODE_93";
      case BarcodeTypes.code128:
        return "CODE_128";
      case BarcodeTypes.dataMatrix:
        return "DATA_MATRIX";
      case BarcodeTypes.ean8:
        return "EAN_8";
      case BarcodeTypes.ean13:
        return "EAN_13";
      case BarcodeTypes.itf:
        return "ITF";
      case BarcodeTypes.maxicode:
        return "MAXICODE";
      case BarcodeTypes.pdf417:
        return "PDF_417";
      case BarcodeTypes.qrCode:
        return "QR_CODE";
      case BarcodeTypes.rss14:
        return "RSS_14";
      case BarcodeTypes.rssExpanded:
        return "RSS_EXPANDED";
      case BarcodeTypes.upcA:
        return "UPC_A";
      case BarcodeTypes.upcE:
        return "UPC_E";
      case BarcodeTypes.upcEanExtension:
        return "UPC_EAN_EXTENSION";
      default:
        throw UnimplementedError("Not implemented.");
    }
  }
}
