import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gpos720_printer/print_types.dart';
import 'package:gpos720_printer/text_options.dart';
import 'alignment_types.dart';
import 'barcode_types.dart';
import 'font_model.dart';
import 'gpos720_printer_platform_interface.dart';

/// An implementation of [Gpos720PrinterPlatform] that uses method channels.
class MethodChannelGpos720Printer extends Gpos720PrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gpos720_printer');

  @override
  Future<String?> getPlatformVersion() {
    return methodChannel.invokeMethod<String>('getPlatformVersion');
  }

  @override
  Future<String?> checarImpressora() {
    return methodChannel.invokeMethod<String>('checarImpressora');
  }

  @override
  Future<String?> fimimpressao() {
    return methodChannel.invokeMethod<String>('fimImpressao');
  }

  @override
  Future<String?> avancaLinha(int quantLinhas) {
    return methodChannel
        .invokeMethod<String>('avancaLinha', {"quantLinhas": quantLinhas});
  }

  @override
  Future<String?> imprimirTexto(String mensagem, TextOptions options, int size,
      Font font, AlignmentTypes align) {
    return methodChannel.invokeMethod<String>('imprimir', {
      "tipoImpressao": PrintTypes.texto.getLabel(),
      "mensagem": mensagem,
      "options": options.toList(),
      "size": size,
      "font": font.fontName,
      "align": align.getLabel()
    });
  }

  @override
  Future<String?> imprimirImagem(
      Uint8List data, int width, int height, AlignmentTypes align) {
    return methodChannel.invokeMethod<String>('imprimir', {
      "tipoImpressao": PrintTypes.imagem.getLabel(),
      "data": data,
      "width": width,
      "height": height,
      "align": align.getLabel()
    });
  }

  @override
  Future<String?> imprimirCodigoDeBarra(
      String mensagem, int width, int height, BarcodeTypes barcodeType) {
    return methodChannel.invokeMethod<String>('imprimir', {
      "tipoImpressao": PrintTypes.codgigoDeBarra.getLabel(),
      "mensagem": mensagem,
      "width": width,
      "height": height,
      "barCode": barcodeType.getLabel()
    });
  }

  @override
  Future<String?> imprimirTodasFuncoes(Uint8List data, int width, int height) {
    return methodChannel.invokeMethod<String>('imprimir', {
      "tipoImpressao": PrintTypes.todasFuncoes.getLabel(),
      "data": data,
      "width": width,
      "height": height
    });
  }
}
