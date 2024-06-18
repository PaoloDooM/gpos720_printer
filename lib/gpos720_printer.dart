import 'dart:typed_data';
import 'package:gpos720_printer/constants.dart';
import 'package:gpos720_printer/printer_status.dart';
import 'package:gpos720_printer/text_options.dart';
import 'alignment_types.dart';
import 'barcode_types.dart';
import 'font_model.dart';
import 'gpos720_printer_platform_interface.dart';

class Gpos720Printer {
  Future<String> getPlatformVersion() {
    return Gpos720PrinterPlatform.instance.getPlatformVersion();
  }

  Future<PrinterStatus> checarImpressora() {
    return Gpos720PrinterPlatform.instance.checarImpressora();
  }

  Future<PrinterStatus> avancaLinha(int quantLinhas) {
    return Gpos720PrinterPlatform.instance.avancaLinha(quantLinhas);
  }

  Future<PrinterStatus> imprimirTexto(String mensagem,
      {TextOptions? options,
      int size = defaultFontSize,
      Font? font,
      AlignmentTypes align = AlignmentTypes.left}) {
    return Gpos720PrinterPlatform.instance.imprimirTexto(mensagem,
        options: options, size: size, font: font, align: align);
  }

  Future<PrinterStatus> imprimirImagem(Uint8List data, int width, int height,
      {AlignmentTypes align = AlignmentTypes.center}) {
    return Gpos720PrinterPlatform.instance
        .imprimirImagem(data, width, height, align: align);
  }

  Future<PrinterStatus> imprimirCodigoDeBarra(
      String mensagem, int width, int height, BarcodeTypes barcodeType) {
    return Gpos720PrinterPlatform.instance
        .imprimirCodigoDeBarra(mensagem, width, height, barcodeType);
  }

  Future<PrinterStatus> imprimirCodigoDeBarraImg(
      String mensagem, int width, int height, BarcodeTypes barcodeType) {
    return Gpos720PrinterPlatform.instance
        .imprimirCodigoDeBarraImg(mensagem, width, height, barcodeType);
  }

  Future<PrinterStatus> imprimirTodasFuncoes(
      Uint8List data, int width, int height) {
    return Gpos720PrinterPlatform.instance
        .imprimirTodasFuncoes(data, width, height);
  }
}
