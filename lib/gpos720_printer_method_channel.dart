import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gpos720_printer/constants.dart';
import 'package:gpos720_printer/print_types.dart';
import 'package:gpos720_printer/printer_status.dart';
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
  Future<String> getPlatformVersion() async {
    return (await methodChannel.invokeMethod<String>('getPlatformVersion')) ??
        "-1";
  }

  @override
  Future<PrinterStatus> checarImpressora() async {
    int? status = int.tryParse(
        await methodChannel.invokeMethod<String>('checarImpressora') ?? '');
    return PrinterStatus
        .values[status ?? PrinterStatus.statusDesconhecido.index];
  }

  @override
  Future<PrinterStatus> fimImpressao() async {
    int? status = int.tryParse(
        await methodChannel.invokeMethod<String>('fimImpressao') ?? '');
    return PrinterStatus
        .values[status ?? PrinterStatus.statusDesconhecido.index];
  }

  @override
  Future<PrinterStatus> avancaLinha(int quantLinhas) async {
    int? status = int.tryParse(await methodChannel.invokeMethod<String>(
            'avancaLinha', {"quantLinhas": quantLinhas}) ??
        '');
    return PrinterStatus
        .values[status ?? PrinterStatus.statusDesconhecido.index];
  }

  @override
  Future<PrinterStatus> imprimirTexto(String mensagem,
      {TextOptions? options,
      int size = defaultFontSize,
      Font? font,
      AlignmentTypes align = AlignmentTypes.left}) async {
    int? status =
        int.tryParse(await methodChannel.invokeMethod<String>('imprimir', {
              "tipoImpressao": PrintTypes.texto.getLabel(),
              "mensagem": mensagem,
              "options": options?.toList() ?? TextOptions().toList(),
              "size": size,
              "font": font?.fontName ?? Font().fontName,
              "align": align.getLabel()
            }) ??
            '');
    return PrinterStatus
        .values[status ?? PrinterStatus.statusDesconhecido.index];
  }

  @override
  Future<PrinterStatus> imprimirImagem(Uint8List data, int width, int height,
      {AlignmentTypes align = AlignmentTypes.center}) async {
    int? status =
        int.tryParse(await methodChannel.invokeMethod<String>('imprimir', {
              "tipoImpressao": PrintTypes.imagem.getLabel(),
              "data": data,
              "width": width,
              "height": height,
              "align": align.getLabel()
            }) ??
            '');
    return PrinterStatus
        .values[status ?? PrinterStatus.statusDesconhecido.index];
  }

  @override
  Future<PrinterStatus> imprimirCodigoDeBarra(
      String mensagem, int width, int height, BarcodeTypes barcodeType) async {
    int? status =
        int.tryParse(await methodChannel.invokeMethod<String>('imprimir', {
              "tipoImpressao": PrintTypes.codgigoDeBarra.getLabel(),
              "mensagem": mensagem,
              "width": width,
              "height": height,
              "barCode": barcodeType.getLabel()
            }) ??
            '');
    return PrinterStatus
        .values[status ?? PrinterStatus.statusDesconhecido.index];
  }

  @override
  Future<PrinterStatus> imprimirTodasFuncoes(
      Uint8List data, int width, int height) async {
    int? status =
        int.tryParse(await methodChannel.invokeMethod<String>('imprimir', {
              "tipoImpressao": PrintTypes.todasFuncoes.getLabel(),
              "data": data,
              "width": width,
              "height": height
            }) ??
            '');
    return PrinterStatus
        .values[status ?? PrinterStatus.statusDesconhecido.index];
  }
}
