import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpos720_printer/alignment_types.dart';
import 'package:gpos720_printer/barcode_types.dart';
import 'package:gpos720_printer/constants.dart';
import 'package:gpos720_printer/font_model.dart';
import 'package:gpos720_printer/gpos720_printer.dart';
import 'package:gpos720_printer/gpos720_printer_platform_interface.dart';
import 'package:gpos720_printer/gpos720_printer_method_channel.dart';
import 'package:gpos720_printer/text_options.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGpos720PrinterPlatform
    with MockPlatformInterfaceMixin
    implements Gpos720PrinterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> avancaLinha(int quantLinhas) {
    // TODO: implement avancaLinha
    return Future.value("");
  }

  @override
  Future<String?> checarImpressora() {
    // TODO: implement checarImpressora
    return Future.value("");
  }

  @override
  Future<String?> fimimpressao() {
    // TODO: implement fimimpressao
    return Future.value("");
  }

  @override
  Future<String?> imprimirCodigoDeBarra(
      String mensagem, int width, int height, BarcodeTypes barcodeType) {
    // TODO: implement imprimirCodigoDeBarra
    return Future.value("");
  }

  @override
  Future<String?> imprimirImagem(Uint8List data, int width, int height,
      {AlignmentTypes align = AlignmentTypes.center}) {
    // TODO: implement imprimirImagem
    return Future.value("");
  }

  @override
  Future<String?> imprimirTexto(String mensagem,
      {TextOptions? options,
      int size = defaultFontSize,
      Font? font,
      AlignmentTypes align = AlignmentTypes.left}) {
    // TODO: implement imprimirTexto
    return Future.value("");
  }

  @override
  Future<String?> imprimirTodasFuncoes(Uint8List data, int width, int height) {
    // TODO: implement imprimirTodasFuncoes
    return Future.value("");
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
