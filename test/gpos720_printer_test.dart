import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpos720_printer/alignment_types.dart';
import 'package:gpos720_printer/barcode_types.dart';
import 'package:gpos720_printer/constants.dart';
import 'package:gpos720_printer/font_model.dart';
import 'package:gpos720_printer/gpos720_printer.dart';
import 'package:gpos720_printer/gpos720_printer_platform_interface.dart';
import 'package:gpos720_printer/gpos720_printer_method_channel.dart';
import 'package:gpos720_printer/printer_status.dart';
import 'package:gpos720_printer/text_options.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGpos720PrinterPlatform
    with MockPlatformInterfaceMixin
    implements Gpos720PrinterPlatform {
  @override
  Future<String> getPlatformVersion() => Future.value('42');

  @override
  Future<PrinterStatus> avancaLinha(int quantLinhas) {
    // TODO: implement avancaLinha
    return Future.value(PrinterStatus.impressoraOk);
  }

  @override
  Future<PrinterStatus> checarImpressora() {
    // TODO: implement checarImpressora
    return Future.value(PrinterStatus.impressoraOk);
  }

  @override
  Future<PrinterStatus> imprimirCodigoDeBarra(
      String mensagem, int width, int height, BarcodeTypes barcodeType) {
    // TODO: implement imprimirCodigoDeBarra
    return Future.value(PrinterStatus.impressoraOk);
  }

  @override
  Future<PrinterStatus> imprimirCodigoDeBarraImg(
      String mensagem, int width, int height, BarcodeTypes barcodeType) {
    // TODO: implement imprimirCodigoDeBarraImg
    return Future.value(PrinterStatus.impressoraOk);
  }

  @override
  Future<PrinterStatus> imprimirImagem(Uint8List data, int width, int height,
      {AlignmentTypes align = AlignmentTypes.center}) {
    // TODO: implement imprimirImagem
    return Future.value(PrinterStatus.impressoraOk);
  }

  @override
  Future<PrinterStatus> imprimirTexto(String mensagem,
      {TextOptions? options,
      int size = defaultFontSize,
      Font? font,
      AlignmentTypes align = AlignmentTypes.left}) {
    // TODO: implement imprimirTexto
    return Future.value(PrinterStatus.impressoraOk);
  }

  @override
  Future<PrinterStatus> imprimirTodasFuncoes(
      Uint8List data, int width, int height) {
    // TODO: implement imprimirTodasFuncoes
    return Future.value(PrinterStatus.impressoraOk);
  }

  @override
  Future<PrinterStatus> imprimirImagemFiltrada(
      Uint8List data, int width, int height,
      {AlignmentTypes align = AlignmentTypes.center, double? threshold}) {
    // TODO: implement imprimirImagemFiltrada
    return Future.value(PrinterStatus.impressoraOk);
  }
}

void main() {
  final Gpos720PrinterPlatform initialPlatform =
      Gpos720PrinterPlatform.instance;

  test('$MethodChannelGpos720Printer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGpos720Printer>());
  });

  test('getPlatformVersion', () async {
    Gpos720Printer gpos720PrinterPlugin = Gpos720Printer();
    MockGpos720PrinterPlatform fakePlatform = MockGpos720PrinterPlatform();
    Gpos720PrinterPlatform.instance = fakePlatform;
    expect(await gpos720PrinterPlugin.getPlatformVersion(), '42');
  });
}
