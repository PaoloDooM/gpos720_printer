import 'dart:typed_data';
import 'package:gpos720_printer/text_options.dart';
import 'alignment_types.dart';
import 'barcode_types.dart';
import 'gpos720_printer_platform_interface.dart';

class Gpos720Printer {
  Future<String?> getPlatformVersion() {
    return Gpos720PrinterPlatform.instance.getPlatformVersion();
  }

  Future<String?> checarImpressora() {
    return Gpos720PrinterPlatform.instance.checarImpressora();
  }

  Future<String?> fimimpressao() {
    return Gpos720PrinterPlatform.instance.fimimpressao();
  }

  Future<String?> avancaLinha(int quantLinhas) {
    return Gpos720PrinterPlatform.instance.avancaLinha(quantLinhas);
  }

  Future<String?> imprimirTexto(String mensagem, TextOptions options, int size,
      String font, AlignmentTypes align) {
    return Gpos720PrinterPlatform.instance
        .imprimirTexto(mensagem, options, size, font, align);
  }

  Future<String?> imprimirImagem(
      Uint8List data, int width, int height, AlignmentTypes align) {
    return Gpos720PrinterPlatform.instance
        .imprimirImagem(data, width, height, align);
  }

  Future<String?> imprimirCodigoDeBarra(
      String mensagem, int width, int height, BarcodeTypes barcodeType) {
    return Gpos720PrinterPlatform.instance
        .imprimirCodigoDeBarra(mensagem, width, height, barcodeType);
  }

  Future<String?> imprimirTodasFuncoes(Uint8List data, int width, int height) {
    return Gpos720PrinterPlatform.instance
        .imprimirTodasFuncoes(data, width, height);
  }
}
